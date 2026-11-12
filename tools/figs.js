// Text-driven SVG figure generators for the .t DSL. Each takes (lines[], caption) and returns an HTML string.
// No MathJax inside figures: labels are plain text; "x^2" -> superscript, "r_1" -> subscript. Colors come from CSS classes (fg-*), so dark mode works.
const E = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
let uid = 0;
// label formatting: ^x ^{..} _x _{..}
function fmt(s) {
  const segs = []; const re = /([\^_])(\{[^}]*\}|[-+]?\d+|[A-Za-z])/g; let last = 0, m;
  while ((m = re.exec(s))) { if (m.index > last) segs.push([s.slice(last, m.index), 0]); segs.push([m[2].replace(/[{}]/g, ''), m[1] === '^' ? 1 : 2]); last = re.lastIndex; }
  if (last < s.length) segs.push([s.slice(last), 0]);
  let out = '', pend = 0;
  for (const [t, k] of segs) {
    if (k === 0) { out += pend ? `<tspan dy="${-pend}">${E(t)}</tspan>` : E(t); pend = 0; }
    else { const d = k === 1 ? -5 : 4; out += `<tspan dy="${pend ? d - pend : d}" font-size="10">${E(t)}</tspan>`; pend = d; }
  }
  if (pend) out += `<tspan dy="${-pend}"></tspan>`;
  return out;
}
const tw = s => { s = s.replace(/[\^_{}]/g, ''); let w = 0; for (const c of s) w += c.charCodeAt(0) > 255 ? 14 : 8; return w; };
const svg = (W, H, inner, cap) => `<figure class="fg"><svg viewBox="0 0 ${W} ${H}" role="img" aria-label="${E(cap || '示意图')}" style="width:100%;max-width:${W}px;height:auto;margin:0 auto;display:block">${inner}</svg>${cap ? `<figcaption>${E(cap.replace(/[{}]/g, ''))}</figcaption>` : ''}</figure>\n`;
const T = (x, y, s, cls = 'fg-txt', anchor = 'middle') => `<text x="${x.toFixed(1)}" y="${y.toFixed(1)}" class="${cls}" text-anchor="${anchor}">${fmt(s)}</text>`;
const col = c => ({a: 'fg-a', b: 'fg-b', c: 'fg-c', d: 'fg-d'}[c] || 'fg-box');
const swatch = (x, y, c, label) => `<rect x="${x}" y="${y - 10}" width="14" height="14" rx="3" class="${col(c)}"/>` + T(x + 20, y + 2, label, 'fg-sm', 'start');
const legW = L => Math.max(0, ...L.filter(l => /^legend\s/.test(l)).map(l => 24 + tw(l.replace(/^legend\s+\w\s+/, '')) * .9 + 30));
const legend = (L, W, y0) => { // lines "legend a text"
  const items = L.filter(l => /^legend\s/.test(l)).map(l => l.match(/^legend\s+(\w)\s+(.*)$/)).filter(Boolean);
  if (!items.length) return ['', 0]; let x = 12, y = y0, s = '';
  for (const [, c, t] of items) { const w = 24 + tw(t) * .9 + 14; if (x + w > W) { x = 12; y += 22; } s += swatch(x, y, c, t); x += w; }
  return [s, y - y0 + 26];
};

// ---------- flow / strip: boxes in rows ----------
function flow(L, cap, arrows = true) {
  const mk = (t, lab) => { const m = t.match(/^\[(\w)\]\s*(.*)$/); return {c: m ? m[1] : '', t: m ? m[2] : t, lab: lab || ''}; };
  const rows = L.filter(l => l.trim() && !/^legend\s/.test(l)).map(l => {
    if (!arrows) return l.split(/\s*\|\s*/).map(t => mk(t));
    const p = l.split(/\s*-(?:\{([^}]*)\})?>\s*/), r = [];  // [item, label, item, label, item ...]
    for (let i = 0; i < p.length; i += 2) r.push(mk(p[i], i + 1 < p.length ? p[i + 1] : ''));
    return r;
  });
  const bw = r => tw(r.t) + 22, GAP = arrows ? 44 : 8, MAXW = 500;
  const gapOf = (r, i) => Math.max(GAP, tw(r[i - 1].lab || '') + 16);
  // split each logical row into chunks that fit MAXW (so text stays readable on phones)
  const rows2 = rows.map(r => { const ch = []; let cur = [], w = 0;
    r.forEach((b, i) => { const add = bw(b) + (cur.length ? gapOf(r, i) : 0); if (cur.length && w + add > MAXW) { ch.push(cur); cur = []; w = 0; } w += bw(b) + (cur.length ? gapOf(r, i) : 0); cur.push({b, g: cur.length ? gapOf(r, i) : 0}); });
    ch.push(cur); return ch; });
  const cw = c => c.reduce((s, o) => s + bw(o.b) + o.g, 0);
  const W = Math.max(320, Math.max(...rows2.flat().map(cw)) + 28); let y = 14, s = '';
  rows2.forEach(chunks => {
    let prevEnd = null;
    chunks.forEach((c, ci) => {
      const wrapped = chunks.length > 1; let x = wrapped ? 14 : (W - cw(c)) / 2, firstX = null;
      c.forEach((o, i) => {
        const b = o.b, g = o.g;
        if (i) { if (arrows) s += `<path d="M${x + 4} ${y + 17}H${x + g - 4}" class="fg-ln"/><path d="M${x + g - 10} ${y + 12}L${x + g - 4} ${y + 17}L${x + g - 10} ${y + 22}" class="fg-ln"/>` + (c[i - 1].b.lab ? T(x + g / 2, y + 10, c[i - 1].b.lab, 'fg-sm') : ''); x += g; }
        const w = bw(b); if (i === 0) firstX = x + w / 2;
        s += `<rect x="${x.toFixed(1)}" y="${y}" width="${w}" height="34" rx="7" class="${col(b.c)}"/>` + T(x + w / 2, y + 22, b.t); x += w;
      });
      if (prevEnd && arrows) s += (chunks[ci - 1].slice(-1)[0].b.lab ? T((prevEnd + firstX) / 2, y - 18, chunks[ci - 1].slice(-1)[0].b.lab, 'fg-sm') : '') + `<path d="M${prevEnd.toFixed(1)} ${y - 28}V${y - 14}H${firstX.toFixed(1)}V${y - 3}" class="fg-ln"/><path d="M${(firstX - 5).toFixed(1)} ${y - 8}L${firstX.toFixed(1)} ${y - 2}L${(firstX + 5).toFixed(1)} ${y - 8}" class="fg-ln"/>`;
      prevEnd = x - bw(c[c.length - 1].b) / 2;
      y += ci < chunks.length - 1 ? 68 : 54;
    });
  });
  const W2 = Math.max(W, legW(L)); const [lg, lh] = legend(L, W2, y); return svg(W2, y + lh - 6, s + lg, cap);
}
const strip = (L, cap) => flow(L, cap, false);

// ---------- blocks: factor blocks, common ones highlighted ----------
function blocks(L, cap) {
  const rows = L.filter(l => /[:：]/.test(l) && !/^legend/.test(l)).map(l => { const i = l.search(/[:：]/); let n = l.slice(0, i).trim(); const res = n.startsWith('='); if (res) n = n.slice(1); return {n, res, toks: l.slice(i + 1).trim().split(/\s+/).filter(Boolean)}; });
  const reg = rows.filter(r => !r.res), cnt = t => r => r.toks.filter(x => x === t).length;
  const minc = {}; new Set(reg.flatMap(r => r.toks)).forEach(t => minc[t] = Math.min(...reg.map(cnt(t))));
  const bw = t => tw(t) + 18, LW = 62;
  const widths = rows.map(r => LW + r.toks.reduce((s, t) => s + bw(t) + 6, 0));
  const W = Math.max(300, Math.max(...widths) + 16); let y = 10, s = '';
  for (const r of rows) {
    s += T(LW - 10, y + 22, r.n, 'fg-ac', 'end'); let x = LW; const seen = {};
    for (const t of r.toks) {
      seen[t] = (seen[t] || 0) + 1; const common = r.res || (seen[t] <= minc[t]); const w = bw(t);
      s += `<rect x="${x}" y="${y}" width="${w}" height="32" rx="6" class="${r.res ? 'fg-c' : common ? 'fg-a' : 'fg-box'}"/>` + T(x + w / 2, y + 21, t); x += w + 6;
    }
    y += 44;
  }
  const W2 = Math.max(W, legW(L)); const [lg, lh] = legend(L, W2, y); return svg(W2, y + lh - 2, s + lg, cap);
}

// ---------- venn ----------
function venn(L, cap) {
  const g = {}; let gap = 140; for (const l of L) { const m = l.match(/^(\w+)\s+(.*)$/); if (m) m[1] === 'gap' ? gap = +m[2] : g[m[1]] = m[2]; }
  const W = 480, H = 240, r = 88, cy = 125, cl = W / 2 - gap / 2, cr = W / 2 + gap / 2; let s = '';
  s += `<circle cx="${cl}" cy="${cy}" r="${r}" class="fg-a" style="fill-opacity:.55"/><circle cx="${cr}" cy="${cy}" r="${r}" class="fg-b" style="fill-opacity:.55"/>`;
  const lines = (k, x, y) => (g[k] ? g[k].split('|').map((t, i, a) => T(x, y + (i - (a.length - 1) / 2) * 18, t.trim())).join('') : '');
  s += T(W / 2 - 6, 18, g.LT || '', 'fg-ac', 'end') + T(W / 2 + 6, 18, g.RT || '', 'fg-ac', 'start');
  s += lines('L', (cl - r + cr - r) / 2, cy) + lines('R', (cl + r + cr + r) / 2, cy) + lines('M', W / 2, cy);
  if (g.B) s += T(W / 2, H - 6, g.B, 'fg-sm'); return svg(W, H, s, cap);
}

// ---------- roots of unity on the complex plane ----------
function roots(L, cap) {
  let n = 6, hi = [], hl = '', conj = false, poly = true, from = null; for (const l of L) { let m;
    if ((m = l.match(/^n\s+(\d+)/))) n = +m[1]; else if ((m = l.match(/^hi\s+([\d\s]+?)(?:\|\s*(.*))?$/))) { hi = m[1].trim().split(/\s+/).map(Number); hl = m[2] || ''; } else if (/^conj/.test(l)) conj = true; else if (/^nopoly/.test(l)) poly = false; else if ((m = l.match(/^from\s+(\S+)\s+(\S+)(?:\s*\|\s*(.*))?$/))) from = [+m[1], +m[2], m[3] || '']; }
  const W = 360, H = 320, cx = 180, cy = 165, R = 112; let s = '';
  s += `<path d="M${cx - R - 26} ${cy}H${cx + R + 26}M${cx} ${cy - R - 24}V${cy + R + 24}" class="fg-grid"/><circle cx="${cx}" cy="${cy}" r="${R}" class="fg-ln" style="stroke:var(--muted);stroke-dasharray:4 3"/>` + T(cx + R + 26, cy + 36, '实轴', 'fg-sm', 'end') + T(cx + 8, cy - R - 12, '虚轴', 'fg-sm', 'start');
  const P = k => [cx + R * Math.cos(2 * Math.PI * k / n), cy - R * Math.sin(2 * Math.PI * k / n)];
  if (poly && n > 2) s += `<path d="M${[...Array(n).keys()].map(k => P(k).map(v => v.toFixed(1)).join(' ')).join('L')}Z" class="fg-grid"/>`;
  if (conj) for (let k = 1; 2 * k < n; k++) { const a = P(k), b = P(n - k); s += `<path d="M${a[0].toFixed(1)} ${a[1].toFixed(1)}L${b[0].toFixed(1)} ${b[1].toFixed(1)}" class="fg-ln" style="stroke:var(--idea);stroke-dasharray:4 3"/>`; }
  if (from) { const fx = cx + R * from[0], fy = cy - R * from[1]; for (let k = 0; k < n; k++) { const [x, y] = P(k); if (Math.hypot(x - fx, y - fy) > 1) s += `<path d="M${fx.toFixed(1)} ${fy.toFixed(1)}L${x.toFixed(1)} ${y.toFixed(1)}" class="fg-ln" style="stroke:var(--idea);stroke-width:1.6"/>`; } s += `<circle cx="${fx.toFixed(1)}" cy="${fy.toFixed(1)}" r="6" class="fg-dot"/>` + (from[2] ? T(fx, fy + 20, from[2], 'fg-ac') : ''); }
  for (let k = 0; k < n; k++) { const [x, y] = P(k), on = hi.includes(k), lab = k === 0 ? '1' : n <= 12 ? 'ω' + (k > 1 ? '^' + k : '') : '';
    s += `<circle cx="${x.toFixed(1)}" cy="${y.toFixed(1)}" r="${on ? 6 : 5}" class="${on ? 'fg-dot2' : 'fg-box'}"/>` + (lab ? T(cx + (R + 22) * Math.cos(2 * Math.PI * k / n), cy - (R + 22) * Math.sin(2 * Math.PI * k / n) + 5, lab, on ? 'fg-ac' : 'fg-txt') : ''); }
  if (hl) s += `<circle cx="14" cy="14" r="6" class="fg-dot2"/>` + T(26, 19, hl, 'fg-sm', 'start');
  return svg(W, H, s, cap);
}

// ---------- bars: degree comparison ----------
function bars(L, cap) {
  const rows = [], marks = []; for (const l of L) { let m; if ((m = l.match(/^mark\s+([\d.]+)\s*\|\s*(.*)$/))) marks.push([+m[1], m[2]]); else if (l.includes('|')) { const [a, b, c = '', d = ''] = l.split('|').map(x => x.trim()); rows.push({a, v: +b, c, d: d || b}); } }
  const mx = Math.max(...rows.map(r => r.v), ...marks.map(m => m[0]), 1), LW = 84, BW = 260, u = BW / mx;
  const W = Math.max(LW + BW + 40, LW + BW + 14 + Math.max(...rows.map(r => tw(r.d))) * .95); let y = marks.length ? 34 : 12, s = '';
  const xr = LW + Math.max(mx, 0) * u + 12;  // text column right of the longest bar / marker
  for (const [v, t] of marks) s += `<path d="M${LW + v * u} 24V${y + rows.length * 34 - 4}" class="fg-ln" style="stroke:var(--cancel);stroke-dasharray:5 4"/>` + T(LW + v * u, 16, t, 'fg-sm');
  for (const r of rows) { s += T(LW - 8, y + 19, r.a, 'fg-txt', 'end') + `<rect x="${LW}" y="${y + 3}" width="${Math.max(r.v * u, 2)}" height="22" rx="4" class="${col(r.c)}"/>` + T(xr, y + 19, r.d, 'fg-sm', 'start'); y += 34; }
  const [lg, lh] = legend(L, W, y + 4); return svg(W, y + lh, s + lg, cap);
}

// ---------- plot: function graphs ----------
const cvc = st => ({dash: 'fg-cv2', g: 'fg-cv3', r: 'fg-cv4'}[st] || 'fg-cv');
function plot(L, cap) {
  let X = [-5, 5], Y = null; const fns = [], pts = [], vls = [], W = 480, H = 280, m = {l: 38, r: 14, t: 14, b: 28};
  for (const l of L) { let r;
    if ((r = l.match(/^x\s+(\S+)\s+(\S+)$/))) X = [+r[1], +r[2]]; else if ((r = l.match(/^y\s+(\S+)\s+(\S+)$/))) Y = [+r[1], +r[2]];
    else if ((r = l.match(/^fn\s+(.*)$/))) { const [e, lab = '', st = ''] = r[1].split('|').map(x => x.trim()); fns.push({f: new Function('x', 'with(Math){return ' + e.replace(/^\s*-/, '0-').replace(/\^/g, '**') + '}'), lab, st}); }
    else if ((r = l.match(/^pt\s+(\S+)\s+(\S+)\s*(?:\|\s*(.*))?$/))) { const [t, pos = ''] = (r[3] || '').split('|').map(x => x.trim()); pts.push([+r[1], +r[2], t, pos]); }
    else if ((r = l.match(/^vl\s+(\S+)\s*(?:\|\s*(.*))?$/))) vls.push([+r[1], r[2] || '']); }
  if (fns.some(f => f.lab)) m.t = 36;
  const N = 260, samp = fns.map(fn => Array.from({length: N + 1}, (_, i) => { const x = X[0] + (X[1] - X[0]) * i / N; let y; try { y = fn.f(x); } catch (e) { y = NaN; } return [x, y]; }));
  if (!Y) { const ys = samp[0].map(p => p[1]).filter(isFinite); const lo = Math.min(...ys, 0), hi = Math.max(...ys, 0), pad = (hi - lo) * .08 || 1; Y = [lo - pad, hi + pad]; }
  const sx = x => m.l + (x - X[0]) / (X[1] - X[0]) * (W - m.l - m.r), sy = y => H - m.b - (y - Y[0]) / (Y[1] - Y[0]) * (H - m.t - m.b);
  const nice = r => { const raw = r / 8, p = 10 ** Math.floor(Math.log10(raw)); return [1, 2, 5, 10].map(k => k * p).find(v => v >= raw); };
  const id = 'pc' + (++uid); let s = `<clipPath id="${id}"><rect x="${m.l}" y="${m.t}" width="${W - m.l - m.r}" height="${H - m.t - m.b}"/></clipPath>`;
  const tk = (lo, hi) => { const st = nice(hi - lo), a = []; for (let v = Math.ceil(lo / st) * st; v <= hi + 1e-9; v += st) a.push(+v.toPrecision(10)); return a; };
  const ax = Y[0] < 0 && Y[1] > 0 ? sy(0) : H - m.b, ay = X[0] < 0 && X[1] > 0 ? sx(0) : m.l;
  for (const v of tk(...X)) s += `<path d="M${sx(v).toFixed(1)} ${m.t}V${H - m.b}" class="fg-grid"/>` + (v ? T(sx(v), H - m.b + 16, String(v), 'fg-sm') : '');
  for (const v of tk(...Y)) s += `<path d="M${m.l} ${sy(v).toFixed(1)}H${W - m.r}" class="fg-grid"/>` + (v ? T(m.l - 5, sy(v) + 4, String(v), 'fg-sm', 'end') : '');
  s += `<path d="M${m.l} ${ax.toFixed(1)}H${W - m.r}M${ay.toFixed(1)} ${m.t}V${H - m.b}" class="fg-ln"/>`;
  for (const [x, t] of vls) s += `<path d="M${sx(x)} ${m.t}V${H - m.b}" class="fg-ln" style="stroke:var(--cancel);stroke-dasharray:5 4"/>` + (t ? T(sx(x) + 4, m.t + 12, t, 'fg-sm', 'start') : '');
  s += `<g clip-path="url(#${id})">`; const rng = Y[1] - Y[0];
  samp.forEach((pp, i) => { let d = '', pen = false; for (const [x, y] of pp) { if (!isFinite(y) || Math.abs(y - (Y[0] + Y[1]) / 2) > 3 * rng) { pen = false; continue; } d += (pen ? 'L' : 'M') + sx(x).toFixed(1) + ' ' + sy(y).toFixed(1); pen = true; } s += `<path d="${d}" class="${cvc(fns[i].st)}"/>`; });
  s += '</g>';
  for (const [x, y, t, pos] of pts) { const right = sx(x) > W - m.r - 70; s += `<circle cx="${sx(x).toFixed(1)}" cy="${sy(y).toFixed(1)}" r="4.5" class="fg-dot"/>` + (t ? T(sx(x) + (right ? -7 : 7), sy(y) + (pos === 'b' ? 20 : -8), t, 'fg-txt', right ? 'end' : 'start') : ''); }
  let lx = m.l; for (const fn of fns) if (fn.lab) { s += `<path d="M${lx} 17h22" class="${cvc(fn.st)}"/>` + T(lx + 28, 21, fn.lab, 'fg-sm', 'start'); lx += 28 + tw(fn.lab) * .9 + 22; }
  return svg(W, H, s, cap);
}

// ---------- synth: synthetic division tables (integers/decimals) ----------
function synth(L, cap) {
  let prev = null, html = '';
  for (const l of L) { const m = l.match(/^(\S+)\s*[:：]\s*(.*)$/); if (!m) continue; const c = +m[1]; let co = m[2].trim() ? m[2].trim().split(/\s+/).map(Number) : prev; if (!co) continue;
    const q = [co[0]], pr = [''], f = x => String(+x.toFixed(6)).replace('-', '−'); for (let i = 1; i < co.length; i++) { pr.push(f(q[i - 1] * c)); q.push(co[i] + q[i - 1] * c); }
    html += `<tr><td class="root">${f(c)}</td>${co.map(v => `<td>${f(v)}</td>`).join('')}</tr><tr><td class="root"></td><td></td>${pr.slice(1).map(v => `<td>${v}</td>`).join('')}</tr><tr class="out"><td class="root"></td>${q.map((v, i) => `<td${i === q.length - 1 ? ' class="rem"' : ''}>${f(v)}</td>`).join('')}</tr><tr><td class="blank" colspan="${co.length + 1}"></td></tr>`;
    prev = q.slice(0, -1); }
  return `<figure class="fg"><div class="scroll"><table class="synth">${html}</table></div>${cap ? `<figcaption>${E(cap)}</figcaption>` : ''}</figure>\n`;
}
module.exports = {flow, strip, blocks, venn, roots, bars, plot, synth};
