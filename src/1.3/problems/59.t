@ex 1.59 25
@prob
求使 $x^2+x+1$ 整除 $(x+1)^m-x^m-1$ 的所有正整数 $m$。
@idea 用工具 (F4)：$x^2+x+1$ 只有单根 $\omega,\omega^2$，所以整除 $\iff$ 这两个根都是 $H_m(x)=(x+1)^m-x^m-1$ 的根。代入 $x=\omega$，利用 $\omega^2+\omega+1=0$、$\omega^3=1$ 把指数化到 $\bmod\,3$，分三种情形。
@step0 先试几个小的 $m$
$m=1$：$(x+1)-x-1=0$，被整除 ✓。
$m=2$：$(x+1)^2-x^2-1=2x$，不被整除。
$m=3$：$3x^2+3x=3x(x+1)$，不被整除。
$m=5$：$(x+1)^5-x^5-1=5x(x+1)(x^2+x+1)$，被整除 ✓。
规律像是：$m=1,5,7,11,\dots$（$m\equiv1,5\pmod 6$）。下面证明它。
@step 先化简根的关系
设 $\omega$ 是 $x^2+x+1$ 的一个根（$\omega=e^{2\pi i/3}$）。则
$$\omega^2+\omega+1=0,\qquad\omega+1=-\omega^2,\qquad\omega^3=1,\qquad\omega\ne0.$$
@roots x²+x+1 的两个根是 3 次单位根中除 1 以外的两个点 ω、ω²（蓝点）；ω³=1 决定了 ω^m 只依赖 m 除以 3 的余数
n 3
hi 1 2 | x²+x+1 的根
conj
@step 把 $H_m(\omega)$ 写成只含 $\omega^{m}$ 的形式
$$H_m(\omega)=(\omega+1)^m-\omega^m-1=(-\omega^2)^m-\omega^m-1=(-1)^m\omega^{2m}-\omega^m-1.$$
@step 分 $m\bmod3$ 讨论
- $m\equiv0$：$\omega^m=\omega^{2m}=1$，$H_m(\omega)=(-1)^m-2$。$m$ 偶时 $=-1$，$m$ 奇时 $=-3$，永远非零。
- $m\equiv1$：$\omega^m=\omega,\ \omega^{2m}=\omega^2$，$H_m(\omega)=(-1)^m\omega^2-\omega-1=(-1)^m\omega^2+\omega^2=\big((-1)^m+1\big)\omega^2$（用 $-\omega-1=\omega^2$）。恰当 $m$ 为奇数时等于 $0$。
- $m\equiv2$：$\omega^m=\omega^2,\ \omega^{2m}=\omega^4=\omega$，$H_m(\omega)=(-1)^m\omega-\omega^2-1=\big((-1)^m+1\big)\omega$（用 $-\omega^2-1=\omega$）。同样恰当 $m$ 为奇数时等于 $0$。
@strip 按 m 除以 6 的余数分类：只有 m≡1,5 (mod 6) 使 H_m(ω)=0
[d]m≡0 | [c]m≡1 | [d]m≡2 | [d]m≡3 | [d]m≡4 | [c]m≡5
legend c H_m(ω)=0，整除成立
legend d H_m(ω)≠0，整除不成立
@step 另一个根 $\omega^2$，并写出结论
$x^2+x+1$ 的两个根 $\omega,\bar\omega=\omega^2$ 是共轭的，$H_m$ 是实系数多项式，$H_m(\omega)=0\Rightarrow H_m(\bar\omega)=\overline{H_m(\omega)}=0$。所以条件 $\iff H_m(\omega)=0\iff m$ 为奇数且 $3\nmid m$：
$$\boxed{m\equiv1\ \text{或}\ 5\pmod 6}\quad(m\ge1).$$
@sum
- “整除 $x^2+x+1$”$\iff$“把 $\omega$ 代入得零”。再利用 $\omega^3=1$，指数只需看 $\bmod\,3$。
- 实系数多项式：一个根为零，共轭根自动为零，不必单独验证。
