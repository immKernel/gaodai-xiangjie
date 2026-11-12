@ex 1.60 25
@prob
设 $m,n,p$ 是非负整数，令 $f(x)=x^{3m}-x^{3n+1}+x^{3p+2}$，$g(x)=x^2-x+1$。证明 $g\mid f$ 当且仅当 $m,n,p$ 同为奇数或同为偶数。
@idea 和上一题一样：代入 $g$ 的根 $\omega$。$g=x^2-x+1$ 的根满足 $\omega^2=\omega-1$，从而 $\omega^3=-1$，所以 $\omega^{3m}=(-1)^m$ 只看 $m$ 的奇偶。然后把 $f(\omega)$ 化成 $A+B\omega$ 的形式，利用 $\omega$ 的虚部非零，得到 $A=B=C$。
@step0 先看两个小例子
$m=n=p=0$：$f=1-x+x^2=g$ ✓（同为偶数）。
$m=1,n=0,p=0$：$f=x^3-x+x^2=x(x^2+x-1)$，$g\nmid f$（奇偶不同）✓。
@step 求 $g$ 的根的性质
$g=x^2-x+1$ 的判别式是 $1-4=-3<0$，两个根是共轭复数 $\omega,\bar\omega$（$\omega=e^{i\pi/3}$）。从 $\omega^2=\omega-1$ 得
$$\omega^3=\omega\cdot\omega^2=\omega^2-\omega=-1.$$
@roots x²−x+1 的根是 6 次单位根里的 ω=e^{iπ/3} 和 ω⁵（蓝点）；它们满足 ω³=−1（在左边的点）
n 6
hi 1 5 | x²−x+1 的根
conj
@step 代入 $\omega$，化简 $f(\omega)$
$\omega^{3m}=(\omega^3)^m=(-1)^m$，$\omega^{3n+1}=(-1)^n\omega$，$\omega^{3p+2}=(-1)^p\omega^2$。记
$$A=(-1)^m,\qquad B=(-1)^n,\qquad C=(-1)^p\quad(\text{都是 }\pm1).$$
则
$$f(\omega)=A-B\omega+C\omega^2=A-B\omega+C(\omega-1)=(A-C)+(C-B)\,\omega.$$
@step “$\Rightarrow$”：$g\mid f$ 则 $A=B=C$
$g\mid f$，所以 $f(\omega)=0$：$(A-C)+(C-B)\omega=0$。$A-C,\ C-B$ 是实数，$\omega$ 的虚部非零，取虚部：$(C-B)\,\mathrm{Im}\,\omega=0$，故 $C=B$；再取实部（或代回）得 $A=C$。所以 $A=B=C$。
@step “$\Leftarrow$”：$A=B=C$ 则 $g\mid f$
$A=B=C$ 时 $f(\omega)=0$。$f$ 是实系数多项式，$f(\bar\omega)=\overline{f(\omega)}=0$。$g$ 的两个根都是 $f$ 的根且 $g$ 只有单根，由工具 (F4)，$g\mid f$。
@step 翻译回奇偶
$A=B=C$ 就是 $(-1)^m=(-1)^n=(-1)^p$，即 $m,n,p$ 同为奇数或同为偶数。证毕。
@strip m, n, p 的奇偶共有 8 种组合：只有“全奇”或“全偶”时 A=B=C，f(ω)=0
[c]偶偶偶 | [d]偶偶奇 | [d]偶奇偶 | [d]偶奇奇
[d]奇偶偶 | [d]奇偶奇 | [d]奇奇偶 | [c]奇奇奇
legend c A=B=C，g | f
legend d 不整除
@sum
- 同样的套路：代根 $\to$ 利用 $\omega^k$ 的周期性化简 $\to$ 令实部、虚部为零。
- $\omega$ 的虚部非零，所以 $x+y\omega=0$（$x,y$ 为实数）$\Rightarrow x=y=0$（把 $\omega$ 当作“另一个独立方向”）。
