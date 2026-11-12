import sys,re
f,ids,out=sys.argv[1],sys.argv[2].split(','),sys.argv[3]
s=open(f).read(); head=s[:s.index('<body>')+6]; figs=''
for i in ids:
    sec=re.search(r'<section class="example" id="%s">.*?</section>'%i,s,re.S).group(0)
    figs+=''.join(re.findall(r'<figure class="fg">.*?</figure>',sec,re.S))
defs=re.findall(r'<svg[^>]*><defs>.*?</defs></svg>',s,re.S)
open(out,'w').write(head+'<main>'+''.join(defs[-1:])+figs+'</main></body></html>')
