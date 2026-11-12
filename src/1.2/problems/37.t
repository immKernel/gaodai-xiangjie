@ex 1.37 17
@prob
设 $f,g\in F[x]$ 均非零，且 $g=p^mg_1$（$m\ge1$）。若 $\gcd(p,g_1)=1$ 且 $p\nmid f$，证明存在 $f_1,r\in F[x]$，使 $r\ne0$，$\deg r<\deg p$，且
$$\frac fg=\frac r{p^m}+\frac{f_1}{p^{m-1}g_1}.$$
@idea 这是“部分分式分解”的第一步：把分母里的 $p^m$ 分离出一个以 $p^m$ 为分母的分式。核心：把 $f$ 写成 $r\,g_1+p\,f_1$，两边除以 $g=p^mg_1$ 就得到结论。
@step0 先看一个小例子
$p=x,\ m=2,\ g_1=x-1$（所以 $g=x^2(x-1)$），$f=1$。要 $\dfrac1{x^2(x-1)}=\dfrac r{x^2}+\dfrac{f_1}{x(x-1)}$，$r$ 是常数。通分后分子：$1=r(x-1)+f_1x$。令 $x=0$：$1=-r$，$r=-1$。则 $f_1x=1+(x-1)=x$，$f_1=1$。
$$\frac1{x^2(x-1)}=\frac{-1}{x^2}+\frac1{x(x-1)}\quad✓\ \big(\text{通分：}-(x-1)+x=1\big)$$
@step 利用 $\gcd(p,g_1)=1$
由 $g\ne0$ 知 $p,g_1$ 都非零。取 $up+vg_1=1$，两边乘 $f$：
$$f=upf+vf\,g_1.$$
@step 把 $vf$ 用 $p$ 除，压小系数
$vf=qp+r$，$\deg r<\deg p$。代入：
$$f=upf+(qp+r)g_1=r\,g_1+p\,(uf+qg_1).$$
令 $f_1=uf+qg_1$，则
$$f=r\,g_1+p\,f_1.$$
@step 证明 $r\ne0$
若 $r=0$，则 $f=pf_1$，即 $p\mid f$，与题设矛盾。所以 $r\ne0$。
@step 两边同时除以 $g=p^mg_1$
$$\frac fg=\frac{r\,g_1}{p^mg_1}+\frac{p\,f_1}{p^mg_1}=\frac r{p^m}+\frac{f_1}{p^{m-1}g_1}.$$
证毕。
@book 补充：允许 $p\mid f$ 的情形
同样的构造照样成立，只是此时允许 $r=0$。事实上 $p\mid f\iff r=0$：$r=0$ 直接推出 $p\mid f$；反过来，若 $p\mid f$，由 $f=rg_1+pf_1$ 得 $p\mid rg_1$，又 $\gcd(p,g_1)=1$，所以 $p\mid r$，结合 $\deg r<\deg p$ 得 $r=0$。
@sum
- 部分分式分解的第一步：$f=rg_1+pf_1$，其中 $r$ 的次数低于 $p$。
- 做法和 [[1.36]] 完全一样：裴蜀等式 $+$ 带余除法压次数。
- 重复这一步，可以把 $f/g$ 彻底分解成一些 $r_i/p^i$ 的和。
