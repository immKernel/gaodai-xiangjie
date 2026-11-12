@ex 1.36 16
@prob
设 $f,g,h\in F[x]$，$h\ne0$，且 $g,h$ 互素。证明存在 $r,s\in F[x]$，使
$$f=gr+hs,\qquad \deg r<\deg h.$$
@idea 裴蜀等式能把任何 $f$ 拆成 $g$ 的倍数加 $h$ 的倍数，但 $g$ 前面的系数 $r$ 可能很大。用 $h$ 做带余除法把 $r$ 压到次数 $<\deg h$，多出来的部分归到 $h$ 的倍数里。
@step0 先看一个例子
$g=x+1,\ h=x-1$，$f=x^3$。要 $x^3=(x+1)r+(x-1)s$ 且 $r$ 是常数（$\deg r<1$）。令 $x=1$：$1=2r$，所以 $r=\tfrac12$。则 $s=\dfrac{x^3-\frac12(x+1)}{x-1}=\dfrac{2x^2+2x+1}{2}=x^2+x+\tfrac12$。
验证：$\tfrac12(x+1)+(x-1)(x^2+x+\tfrac12)=\tfrac12x+\tfrac12+x^3+x^2+\tfrac12x-x^2-x-\tfrac12=x^3$ ✓。
@step 先把 $f$ 用 $h$ 除一下
$f=q_0h+r_0$，$\deg r_0<\deg h$。这样 $f$ 的“主要部分”$r_0$ 已经比 $h$ 小，$q_0h$ 本来就是 $h$ 的倍数。
@step 对 $r_0$ 用裴蜀等式
$g,h$ 互素，取 $Ug+Vh=1$，乘 $r_0$：
$$r_0=u\,g+v\,h,\qquad u=r_0U,\ v=r_0V.$$
这里的 $u$ 可能次数很大，不一定 $<\deg h$。
@step 再把 $u$ 用 $h$ 除，压小
$u=qh+r$，$\deg r<\deg h$。代回所有的式子：
$$\begin{aligned}f&=q_0h+r_0=q_0h+ug+vh\\&=q_0h+(qh+r)g+vh\\&=gr+h\,(q_0+qg+v).\end{aligned}$$
@step 得出结论
取 $r$ 为上面的余式（$\deg r<\deg h$），$s=q_0+qg+v$，就有 $f=gr+hs$。证毕。
@flow 证明路线：先除 h，再裴蜀，再把 g 前面的系数压小
[a]f -{÷ h}> [b]q₀h + r₀ -{r₀ = ug + vh}> [b]q₀h + ug + vh -{u = qh + r}> [c]g·r + h·(q₀+qg+v)
@book 补充说明：为什么要 $h\ne0$
$h=0$ 时 $\deg h=-\infty$（或约定 $\deg 0=-1$），例如 $g=1,h=0$（互素），$f=1$ 要求 $\deg r<\deg h$，没有任何多项式 $r$ 能满足。所以必须假设 $h\ne0$。
@sum
- 把一个多项式拆成 $g\cdot r+h\cdot s$ 并控制 $r$ 的次数：先裴蜀，再对系数做带余除法。
- 带余除法“压次数”、多余部分“转嫁给另一个系数”，是 [[1.18]]、[[1.34]] 里也用过的招数。
