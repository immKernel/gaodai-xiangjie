// Usage: node tools/build.js <section> [--publish]     e.g. node tools/build.js 1.2
//   reads  src/<section>/{meta.json,intro.html?,problems/*.html|*.t}
//   writes <root>/<meta.out>; with --publish also copies to site/<meta.publish> (+ cross-section nav).
// Problem fragments are either raw HTML (*.html, the 1.1 style) or the compact DSL (*.t, see AI-NOTES.md).
const fs = require('fs'), path = require('path');
const {mathjax} = require('mathjax-full/js/mathjax.js');
const {TeX} = require('mathjax-full/js/input/tex.js');
require('mathjax-full/js/input/tex/AllPackages.js');
const {SVG} = require('mathjax-full/js/output/svg.js');
const {liteAdaptor} = require('mathjax-full/js/adaptors/liteAdaptor.js');
const {RegisterHTMLHandler} = require('mathjax-full/js/handlers/html.js');

const sec = process.argv[2] || '1.1', publish = process.argv.includes('--publish');
const root = path.join(__dirname, '..'), src = path.join(root, 'src'), sdir = path.join(src, sec);
const meta = JSON.parse(fs.readFileSync(path.join(sdir, 'meta.json'), 'utf8'));

// ---------- DSL → HTML ----------
const esc = s => s.replace(/</g, '&lt;').replace(/>/g, '&gt;');
const inline = s => esc(s).replace(/&lt;(\/?)b&gt;/g, '<$1b>').replace(/\*\*(.+?)\*\*/g, '<b>$1</b>')
  .replace(/\[\[(\d+)\.(\d+)\]\]/g, '<a href="#ex$1-$2">例 $1.$2</a>');
// body text → blocks: raw html lines (start with "<") pass through; $$..$$ display math; "- " bullets; else <p>
function body(lines) {
  const out = []; let i = 0;
  while (i < lines.length) {
    const L = lines[i];
    if (!L.trim()) { i++; continue; }
    if (L.startsWith('<')) { out.push(L); i++; continue; }
    if (L.startsWith('$$')) {                       // display math, one or many lines
      let buf = [L];
      while (!(buf.join('\n').replace(/^\$\$/, '').includes('$$')) && ++i < lines.length) buf.push(lines[i]);
      out.push(esc(buf.join('\n'))); i++; continue;
    }
    if (L.startsWith('- ')) {
      const li = [];
      while (i < lines.length && lines[i].startsWith('- ')) li.push('<li>' + inline(lines[i++].slice(2)) + '</li>');
      out.push('<ul class="tight">' + li.join('') + '</ul>'); continue;
    }
    const buf = [];
    while (i < lines.length && lines[i].trim() && !/^(<|\$\$|- )/.test(lines[i])) buf.push(lines[i++]);
    out.push('<p>' + inline(buf.join('\n')) + '</p>');
  }
  return out.join('\n');
}
function dsl(text) {
  // split into @directive blocks
  const blocks = []; let cur = null;
  for (const line of text.split('\n')) {
    const m = line.match(/^@(\w+)\s*(.*)$/);
    if (m) { cur = {k: m[1], arg: m[2].trim(), lines: []}; blocks.push(cur); } else if (cur) cur.lines.push(line);
  }
  let h = '', steps = null, step = null;
  const closeStep = () => { if (step) { steps.push(step + '</div></li>'); step = null; } };
  const closeSteps = () => { closeStep(); if (steps) { h += '<ol class="steps">' + steps.join('\n') + '</ol>\n'; steps = null; } };
  for (const b of blocks) {
    const t = body(b.lines);
    if (b.k === 'ex') {                              // @ex 1.15 7   (number, original page)
      const [num, pg] = b.arg.split(/\s+/); const id = 'ex' + num.replace('.', '-');
      h += `<section class="example" id="${id}">\n<h2>例 ${num}</h2>\n`; dsl.pg = pg;
    } else if (b.k === 'prob') h += `<div class="card problem"><span class="tag">题目（原书第 ${dsl.pg} 页）</span>\n${t}\n</div>\n`;
    else if (b.k === 'idea') h += `<p><b>一句话思路：</b>${inline(b.arg)}${t.replace(/^<p>|<\/p>$/g, '')}</p>\n`;
    else if (b.k === 'step' || b.k === 'step0') {
      closeStep(); steps = steps || [];
      step = `<li${b.k === 'step0' ? ' class="zero"' : ''}><div class="step-body"><h3>${inline(b.arg)}</h3>\n${t}\n`;
    } else if (b.k === 'check') step += `<div class="check"><b>${inline(b.arg)}</b>\n${t}</div>\n`;
    else if (b.k === 'why') step += `<div class="idea"><b>${inline(b.arg)}</b>\n${t}</div>\n`;
    else if (b.k === 'book') { closeSteps(); h += `<details><summary>${inline(b.arg || '对照：原书的解析')}</summary>\n${t}\n</details>\n`; }
    else if (b.k === 'sum') { closeSteps(); h += `<div class="summary-box"><h3>这题记住什么</h3>\n${t}\n</div>\n`; }
    else if (b.k === 'raw') step ? step += t + '\n' : h += t + '\n';
    else throw new Error('unknown directive @' + b.k);
  }
  closeSteps();
  return h + '</section>\n';
}

// ---------- assemble ----------
const pdir = path.join(sdir, 'problems');
const files = fs.readdirSync(pdir).filter(f => /\.(html|t)$/.test(f)).sort();
const parts = files.map(f => { const s = fs.readFileSync(path.join(pdir, f), 'utf8'); return f.endsWith('.t') ? dsl(s) : s; });
const ids = parts.map(p => (p.match(/id="(ex[\d-]+)"/) || [])[1]);
const num = id => id.slice(2).replace('-', '.');
const toc = ids.map(id => `<a href="#${id}">例 ${num(id)}</a>`).join('\n');
const back = '<p class="back"><a href="#toc">↑ 回到目录</a></p>';
const intro = fs.existsSync(path.join(sdir, 'intro.html')) ? fs.readFileSync(path.join(sdir, 'intro.html'), 'utf8') : '';
const nav = publish ? '<nav class="card"><div><b>其他小节：</b>' + JSON.parse(fs.readFileSync(path.join(src, 'sections.json'), 'utf8'))
  .map(s => s.id === sec ? `${s.id} ${s.name}（当前）` : `<a href="${s.href}">${s.id} ${s.name}</a>`).join(' ｜ ') + '</div></nav>' : '';
const html = `<!doctype html>
<html lang="zh-CN"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
${fs.readFileSync(path.join(src, 'head.html'), 'utf8').replace(/<title>.*?<\/title>/, `<title>${meta.title}</title>`)}
<style>*{box-sizing:border-box}img{max-width:100%}body{margin:0}</style>
</head><body><main>
<header>
  <div class="eyebrow">${meta.eyebrow}</div>
  <h1>例 ${num(ids[0])} – 例 ${num(ids[ids.length - 1])} 小白版逐题详解</h1>
  <p>每一步只做一件事，不跳步。绿色框是“用具体数字验算”，黄色框是“为什么会想到这样做”。</p>
</header>
${nav}
<nav class="card" id="toc"><h3>目录</h3><div class="toc">${toc}</div></nav>
${intro}
${parts.map(p => p.replace(/<\/section>\s*$/, back + '\n</section>')).join('\n<hr>\n')}
</main></body></html>`;

// ---------- pre-render math to SVG (offline-safe) ----------
const adaptor = liteAdaptor();
RegisterHTMLHandler(adaptor);
const svg = new SVG({fontCache: 'global'});
const doc = mathjax.document(html, {
  InputJax: new TeX({packages: ['base', 'ams', 'newcommand', 'noundefined'], inlineMath: [['$', '$']], displayMath: [['$$', '$$']]}),
  OutputJax: svg
});
doc.render();
const res = adaptor.doctype(doc.document) + '\n' + adaptor.outerHTML(adaptor.root(doc.document));
const errs = res.match(/data-mjx-error="[^"]*"/g) || [];
const leftovers = (res.replace(/<svg[\s\S]*?<\/svg>/g, '').match(/\$[^$<]{1,40}\$/g) || []);
const out = path.join(root, meta.out);
fs.writeFileSync(out, res);
if (publish) fs.copyFileSync(out, path.join(fs.existsSync(path.join(root, 'site')) ? path.join(root, 'site') : root, meta.publish));
console.log(`${files.length} problems, ${(res.match(/<mjx-container/g) || []).length} formulas, ${(res.length / 1024).toFixed(0)} KB → ${out}${publish ? ' (+ site/' + meta.publish + ')' : ''}`);
if (errs.length) console.log('TeX errors:', errs);
if (leftovers.length) console.log('Unrendered:', leftovers.slice(0, 5));
