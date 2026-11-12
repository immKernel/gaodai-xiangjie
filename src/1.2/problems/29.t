@ex 1.29 14
@prob
设多项式 $f,g,h$ 的公因式只有非零常数。证明存在多项式 $u,v,w$，使 $uf+vg+wh=1$。
@idea 分两步走：先把 $f,g$ 合并成它们的最大公因式 $d=u_1f+v_1g$，再证明 $d$ 与 $h$ 互素，最后把 $d=u_1f+v_1g$ 代进 $d$ 与 $h$ 的裴蜀等式里。
@step0 先看一个具体的例子
$f=x(x-1),\ g=x(x+1),\ h=(x-1)(x+1)$。三者没有共同的非常数因子，但两两都有公因式。
$d=\gcd(f,g)=x$，且 $g-f=2x$，所以 $d=-\tfrac12f+\tfrac12g$。又 $x\cdot x-h=x^2-(x^2-1)=1$，即 $d\cdot x+h\cdot(-1)=1$。代入：
$$1=x\Big(-\tfrac12f+\tfrac12g\Big)-h=-\tfrac x2f+\tfrac x2g-h\quad✓$$
@step 先合并 $f,g$
令 $d=\gcd(f,g)$，裴蜀等式：$u_1f+v_1g=d$。
@step 证明 $\gcd(d,h)=1$
只需证 $d,h$ 的公因式 $e$ 一定是常数：
- 若 $e\mid d$ 且 $e\mid h$：因为 $d\mid f,\ d\mid g$，所以 $e\mid f,\ e\mid g,\ e\mid h$，即 $e$ 是 $f,g,h$ 的公因式，由题设 $e$ 是常数。
所以 $\gcd(d,h)=1$。
@step 再对 $(d,h)$ 用一次裴蜀等式，然后代入
有 $u_2,w$ 使 $u_2d+wh=1$。把 $d=u_1f+v_1g$ 代入：
$$1=u_2(u_1f+v_1g)+wh=(u_2u_1)f+(u_2v_1)g+w\,h.$$
取 $u=u_2u_1,\ v=u_2v_1$ 以及 $w$ 即得。证毕。
@flow 先合并两个，再与第三个做一次裴蜀
[a]f, g -{裴蜀}> [b]d = u₁f + v₁g -{d, h 互素，再裴蜀}> [c]1 = u₂d + wh
[c]代入 d：1 = (u₂u₁)f + (u₂v₁)g + wh
@why 想到“先合并两个”的原因
三个多项式一起处理太乱，但“两个多项式的 gcd”我们已经很熟了。把前两个先压成一个 $d$，问题就变成两个多项式互素，裴蜀等式直接可用。
@sum
- 多个多项式的互素 $\iff$ 能凑出 $1$（和两个时一样）。
- 对 $n$ 个多项式，可以逐个合并：$\gcd(f_1,\dots,f_n)=\gcd(\gcd(f_1,\dots,f_{n-1}),f_n)$。
