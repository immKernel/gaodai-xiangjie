@ex 1.25 12
@prob
设 $d=\gcd(f,g)$，且 $f\mid h,\ g\mid h$。证明 $fg\mid dh$。
@idea 这是工具 (E) 的推广：当 $f,g$ 不互素时，$h$ 不一定被 $fg$ 整除，但“补上一个 $d$”就够了。办法：把 $d$ 提出来，剩下的部分 $u,v$ 互素，再用工具 (D)。
@step0 先用数字看看
$f=x(x+1),\ g=x(x-1)$，$d=x$。取 $h=x(x+1)(x-1)$，则 $f\mid h,\ g\mid h$。
$fg=x^2(x+1)(x-1)$，$dh=x\cdot x(x+1)(x-1)=x^2(x+1)(x-1)$，两者恰好相等，所以 $fg\mid dh$ ✓。
@step 提出 $d$，剩下的部分互素
设 $f,g$ 不全为零（全为零见本题最后一句）。写 $f=du,\ g=dv$。取裴蜀等式 $Af+Bg=d$，代入并约去 $d$：
$$A\,du+B\,dv=d\ \Longrightarrow\ Au+Bv=1.$$
所以 $\gcd(u,v)=1$。
@blocks f=du，g=dv，h 含 d u v：dh 恰好有 fg 的全部块
f: d u
g: d v
h: d u v
=dh: d d u v
=fg: d u d v
legend a f, g, h 共有的块
@step 利用 $f\mid h,\ g\mid h$ 写出两个表达式
$$h=fp=d\,u\,p,\qquad h=gq=d\,v\,q.$$
两式相等，约去 $d$：$up=vq$。
@step 用互素约掉
$v\mid up$，而 $\gcd(u,v)=1$，由工具 (D)：$v\mid p$。设 $p=vt$。
@step 算出 $dh$
$$dh=d\cdot fp=d\cdot f\cdot vt=f\cdot(dv)\cdot t=fg\,t.$$
所以 $fg\mid dh$。证毕。
（若 $f,g$ 中有一个为零，比如 $f=0$，则 $f\mid h$ 迫使 $h=0$，此时 $dh=0=(fg)\cdot0$，结论也成立。）
@sum
- 提取公因式 $d$：$f=du,\ g=dv$ 后 $u,v$ 互素，这是处理 gcd 问题的万能起手式。
- 当 $d=1$ 时本题退化成工具 (E)。
