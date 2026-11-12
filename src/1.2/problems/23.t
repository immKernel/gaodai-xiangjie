@ex 1.23 12
@prob
设 $F$ 是数域，$f,g\in F[x]$ 均非零。对任意 $h\in F[x]$，若 $f\mid h$ 且 $g\mid h$，则 $fg\mid h$。证明 $\gcd(f,g)=1$。
@idea 用反证法。如果 $f,g$ 有公共的非常数因子 $d$，就能造出一个同时被 $f$ 和 $g$ 整除、但<b>比 $fg$ 小</b>的多项式 $h=fg/d$，它显然不会被 $fg$ 整除，与题设矛盾。
@step0 先看一个“不互素”的例子是怎么破坏结论的
$f=x(x+1),\ g=x(x-1)$，公共因子 $d=x$。取 $h=x(x+1)(x-1)$，则 $f\mid h$、$g\mid h$，但 $fg=x^2(x+1)(x-1)$ 次数比 $h$ 还高，当然不整除 $h$。
@step 设 $d=\gcd(f,g)$，写 $f=du,\ g=dv$，假设 $\deg d>0$
$u,v$ 都是非零多项式（因为 $f,g\ne0$）。
@step 造一个“最小公倍”的多项式
取 $h=gu$。因为
$$h=gu=dvu=(du)v=fv,$$
所以 $g\mid h$ 且 $f\mid h$。
@why 为什么选 $h=gu$？
$gu=fg/d$。就是把 $fg$ 里重复的 $d$ 去掉一份，它仍然被 $f$ 和 $g$ 整除（这就是“最小公倍式”的想法）。
@blocks 去掉重复的公共块 d，h 比 fg 少一个 d，所以 fg 不可能整除 h
f: d u
g: d v
=h: d u v
=fg: d u d v
legend a f 与 g 的公共块
@step 用题设得到矛盾
由题设 $fg\mid h$，即 $gu=fg\cdot q$。两边约去 $g\ne0$：
$$u=fq.$$
$u\ne0$，所以 $q\ne0$，于是 $\deg u=\deg f+\deg q\ge\deg f$。
另一方面 $\deg u=\deg f-\deg d<\deg f$，矛盾！
@step 结论
所以 $\deg d=0$，$d$ 是常数，首一化后 $d=1$，即 $\gcd(f,g)=1$。证毕。
@book 补充说明（原书）
题目必须要求 $f,g\ne0$。例如 $f=0,\ g=x$：满足“$0\mid h$ 且 $x\mid h$”的 $h$ 只有 $h=0$，而 $0\cdot x\mid0$ 当然成立，但 $\gcd(0,x)=x\ne1$。
@sum
- 这题是工具 (E) 的“逆命题”：$\gcd(f,g)=1\iff$ 对一切 $h$，“$f\mid h,\ g\mid h\Rightarrow fg\mid h$”。
- 反证 + 次数比较：造一个更小的、却被两者整除的多项式。
