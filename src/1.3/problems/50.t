@ex 1.50 21
@prob
分别在实数域与复数域上求 $f(x)=x^n+x^{n-1}+\cdots+x+1$ 的标准分解式。
@idea 先用 $(x-1)f=x^{n+1}-1$ 把 $f$ 的根找出来：$n+1$ 次单位根中去掉 $1$。复数域上直接按根写成一次因式的乘积；实数域上，把共轭的两个非实根配成实系数二次式。
@step0 先看 $n=2$ 和 $n=3$
$n=2$：$f=x^2+x+1$，在 $\mathbb R$ 上不可约（判别式 $-3$）。在 $\mathbb C$ 上 $=(x-\omega)(x-\omega^2)$，$\omega=e^{2\pi i/3}$。
$n=3$：$f=x^3+x^2+x+1=(x+1)(x^2+1)$。
@step 复数域：直接按根分解
$(x-1)f=x^{n+1}-1$。令 $\omega=\cos\dfrac{2\pi}{n+1}+i\sin\dfrac{2\pi}{n+1}$，则 $\omega^k$（$0\le k\le n$）是 $n+1$ 个相异的 $(n+1)$ 次单位根，
$$x^{n+1}-1=(x-1)\prod_{k=1}^{n}(x-\omega^k).$$
约去 $x-1$：
$$\boxed{f(x)=\prod_{k=1}^{n}(x-\omega^k)}\qquad(\mathbb C\text{ 上的标准分解}).$$
@roots n=6（n+1=7，奇数）：f 的 6 个根在单位圆上，互为共轭的成对（虚线），没有实根
n 7
hi 1 2 3 4 5 6 | f 的根
conj
@step 实数域：共轭两两配对
$\omega^{n+1-k}=\overline{\omega^k}$。把 $\omega^k$ 与 $\omega^{n+1-k}$ 配成一对：
$$(x-\omega^k)(x-\overline{\omega^k})=x^2-2\cos\frac{2k\pi}{n+1}\,x+1.$$
这个二次式的判别式是 $4\cos^2\theta-4=-4\sin^2\theta<0$（只要 $\omega^k$ 非实），所以它在 $\mathbb R[x]$ 中不可约。
@step 情形一：$n=2m$（$n+1$ 为奇数）
$n+1=2m+1$ 为奇数，除去 $1$ 之外没有实的单位根。$k=1,\dots,2m$ 恰好配成 $m$ 对，每对取 $1\le k\le m$：
$$f(x)=\prod_{k=1}^{m}\Big(x^2-2\cos\frac{2k\pi}{2m+1}\,x+1\Big).$$
@step 情形二：$n=2m+1$（$n+1$ 为偶数）
$n+1=2m+2$ 为偶数，$\omega^{m+1}=e^{i\pi}=-1$ 是实根，给出线性因式 $x+1$。其余 $2m$ 个根配成 $m$ 对（$1\le k\le m$）：
$$f(x)=(x+1)\prod_{k=1}^{m}\Big(x^2-2\cos\frac{k\pi}{m+1}\,x+1\Big).$$
@roots n=7（n+1=8，偶数）：f 的 7 个根里 −1 是实根（最左边的点），其余 6 个配成 3 对共轭
n 8
hi 1 2 3 4 5 6 7 | f 的根
conj
@check 用开头的小例子核对
$n=3=2\cdot1+1$，$m=1$：$f=(x+1)\big(x^2-2\cos\tfrac\pi2x+1\big)=(x+1)(x^2+1)$ ✓。
$n=2=2\cdot1$，$m=1$：$f=x^2-2\cos\tfrac{2\pi}3x+1=x^2+x+1$ ✓（$\cos\tfrac{2\pi}3=-\tfrac12$）。
@sum
- 复数域：按单位根一个一个写；实数域：共轭根配对 $\to$ 判别式 $<0$ 的二次式。
- 奇偶性：$n+1$ 是奇数时没有实根（除了被约掉的 $1$），是偶数时多一个根 $-1$。
