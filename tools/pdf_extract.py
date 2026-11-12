import re,zlib,sys
d=open(sys.argv[1],'rb').read()
objs={}
for m in re.finditer(rb'(\d+)\s+0\s+obj(.*?)endobj',d,re.S):
    objs[int(m.group(1))]=m.group(2)
# object streams
def stream(body):
    m=re.search(rb'stream\r?\n(.*)endstream',body,re.S)
    if not m: return None
    s=m.group(1)
    try: return zlib.decompress(s)
    except Exception:
        try: return zlib.decompressobj().decompress(s)
        except Exception: return None
for n,b in list(objs.items()):
    if b'/ObjStm' in b:
        s=stream(b); N=int(re.search(rb'/N\s+(\d+)',b).group(1)); F=int(re.search(rb'/First\s+(\d+)',b).group(1))
        hdr=list(map(int,s[:F].split()))
        for i in range(N):
            on,off=hdr[2*i],hdr[2*i+1]
            end=hdr[2*i+3] if i+1<N else len(s)
            objs[on]=s[F+off:F+end]
def ref(b,key):
    m=re.search(rb'/'+key+rb'\s+(\d+)\s+0\s+R',b); return int(m.group(1)) if m else None
def parse_cmap(s):
    mp={}
    for blk in re.findall(rb'beginbfchar(.*?)endbfchar',s,re.S):
        for a,b in re.findall(rb'<([0-9A-Fa-f]+)>\s*<([0-9A-Fa-f]+)>',blk):
            mp[int(a,16)]=bytes.fromhex(b.decode()).decode('utf-16-be','replace')
    for blk in re.findall(rb'beginbfrange(.*?)endbfrange',s,re.S):
        for a,b,c in re.findall(rb'<([0-9A-Fa-f]+)>\s*<([0-9A-Fa-f]+)>\s*<([0-9A-Fa-f]+)>',blk):
            a,b=int(a,16),int(b,16); c=int(c,16)
            for i in range(a,b+1):
                try: mp[i]=chr(c+i-a)
                except: pass
    return mp
fontcache={}
def font(n):
    if n in fontcache: return fontcache[n]
    b=objs[n]; tu=ref(b,b'ToUnicode'); two=b'Identity' in b or b'Type0' in b
    mp=parse_cmap(stream(objs[tu])) if tu else {}
    fontcache[n]=(mp,two); return fontcache[n]
def resources(page):
    r=re.search(rb'/Resources\s*(\d+)\s+0\s+R',page)
    res=objs[int(r.group(1))] if r else page
    fm=re.search(rb'/Font\s*(\d+)\s+0\s+R',res)
    fd=objs[int(fm.group(1))] if fm else (re.search(rb'/Font\s*<<(.*?)>>',res,re.S) or [None,b''])[1] if True else b''
    if not fm:
        m=re.search(rb'/Font\s*<<(.*?)>>',res,re.S); fd=m.group(1) if m else b''
    return {k.decode():int(v) for k,v in re.findall(rb'/(\w+)\s+(\d+)\s+0\s+R',fd)}
# pages in order via Pages tree
root=ref(d[d.rfind(b'trailer'):],b'Root') if b'trailer' in d else None
if root is None:
    for n,b in objs.items():
        if b'/Type/Catalog' in b.replace(b' ',b''): root=n
pages=[]
def walk(n):
    b=objs[n]
    if re.search(rb'/Type\s*/Pages',b):
        kids=re.search(rb'/Kids\s*\[(.*?)\]',b,re.S).group(1)
        for k in re.findall(rb'(\d+)\s+0\s+R',kids): walk(int(k))
    else: pages.append(n)
walk(ref(objs[root],b'Pages'))
tok=re.compile(rb'/([A-Za-z0-9_.+-]+)\s+[\d.]+\s+Tf|\[((?:[^\]\\]|\\.)*)\]\s*TJ|<([0-9A-Fa-f]*)>\s*Tj|\(((?:[^)\\]|\\.)*)\)\s*Tj|([-\d.]+)\s+([-\d.]+)\s+T[dD]|(T\*)|([-\d.]+\s+){5}([-\d.]+)\s+Tm')
def dec_lit(s):
    out=bytearray();i=0
    while i<len(s):
        c=s[i]
        if c==92:
            i+=1;c=s[i]
            if 48<=c<=55:
                j=i
                while j<len(s) and j<i+3 and 48<=s[j]<=55: j+=1
                out.append(int(s[i:j],8)&255);i=j;continue
            out.append({110:10,114:13,116:9}.get(c,c))
        else: out.append(c)
        i+=1
    return bytes(out)
def decode(raw,f):
    mp,two=f
    if two: codes=[raw[i]<<8|raw[i+1] for i in range(0,len(raw)-1,2)]
    else: codes=list(raw)
    return ''.join(mp.get(c,chr(c) if not two else '?') for c in codes)
out=[]
for pi,pn in enumerate(pages):
    p=objs[pn]; fonts=resources(p)
    cm=re.search(rb'/Contents\s*(\d+)\s+0\s+R',p)
    cs=[int(cm.group(1))] if cm else [int(x) for x in re.findall(rb'(\d+)\s+0\s+R',re.search(rb'/Contents\s*\[(.*?)\]',p,re.S).group(1))]
    content=b''.join(stream(objs[c]) or b'' for c in cs)
    cur=None;txt=f'\n=== PAGE {pi+1} ===\n';lasty=None
    for m in tok.finditer(content):
        if m.group(1): cur=font(fonts[m.group(1).decode()]) if m.group(1).decode() in fonts else None
        elif m.group(5) is not None:
            if abs(float(m.group(6)))>1: txt+='\n'
            else: txt+=''
        elif m.group(7): txt+='\n'
        elif m.group(9) is not None: txt+='\n'
        elif cur:
            if m.group(2) is not None:
                for part in re.finditer(rb'<([0-9A-Fa-f]*)>|\(((?:[^)\\]|\\.)*)\)|(-?[\d.]+)',m.group(2)):
                    if part.group(1) is not None: txt+=decode(bytes.fromhex(part.group(1).decode()),cur)
                    elif part.group(2) is not None: txt+=decode(dec_lit(part.group(2)),cur)
                    elif float(part.group(3))<-200: txt+=' '
            elif m.group(3) is not None: txt+=decode(bytes.fromhex(m.group(3).decode()),cur)
            elif m.group(4) is not None: txt+=decode(dec_lit(m.group(4)),cur)
    out.append(txt)
print(''.join(out))
