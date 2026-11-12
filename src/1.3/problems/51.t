@ex 1.51 22
@prob
设 $n$ 为自然数。证明
$$\prod_{k=1}^{n}\cos\frac{k\pi}{2n+1}=\frac1{2^n}.$$
并（附注）证明：设 $n$ 为正整数，$\displaystyle\prod_{k=1}^{n-1}\sin\frac{k\pi}{2n}=\frac{\sqrt n}{2^{n-1}}$。
@idea 把例 1.50 的分解式看成关于 $x$ 的恒等式，代入一个能把二次因式变成 $\cos^2$ 的点：$x=-1$（因为 $x^2-2x\cos2\theta+1$ 在 $x=-1$ 处等于 $2+2\cos2\theta=4\cos^2\theta$）。
@step0 先验证 $n=1,2$
$n=1$：$\cos\dfrac\pi3=\dfrac12=2^{-1}$ ✓。
$n=2$：$\cos\dfrac\pi5\cos\dfrac{2\pi}5=\dfrac{1+\sqrt5}{4}\cdot\dfrac{\sqrt5-1}{4}=\dfrac{4}{16}=\dfrac14=2^{-2}$ ✓。
@step 取例 1.50 的偶数情形
令 $\theta_k=\dfrac{k\pi}{2n+1}$，则 $\dfrac{2k\pi}{2n+1}=2\theta_k$。例 1.50（把 $n$ 换成 $2n$）给出
$$x^{2n+1}-1=(x-1)\prod_{k=1}^{n}\big(x^2-2x\cos2\theta_k+1\big).$$
@step 令 $x=-1$
左边：$(-1)^{2n+1}-1=-2$。右边：$(x-1)=-2$，每个二次因式 $=1+2\cos2\theta_k+1=2+2\cos2\theta_k$。又 $1+\cos2\theta=2\cos^2\theta$，所以 $2+2\cos2\theta_k=4\cos^2\theta_k$：
$$-2=-2\prod_{k=1}^{n}4\cos^2\theta_k=-2\cdot4^n\prod_{k=1}^{n}\cos^2\theta_k.$$
约去 $-2$：$\displaystyle\prod_{k=1}^n\cos^2\theta_k=4^{-n}$。
@step 开方，确定符号
$1\le k\le n$ 时 $0<\theta_k<\dfrac\pi2$，每个 $\cos\theta_k>0$，乘积 $>0$，开方得
$$\prod_{k=1}^n\cos\theta_k=2^{-n}.\qquad\text{证毕。}$$
@roots n=3（2n+1=7）：从点 −1 向 7 个单位根连弦：到点 1 的弦长为 2，其余 6 条弦长是 2cos(kπ/7)，它们的乘积 =1，即 64·(∏cos)²=1
n 7
from -1 0 | −1
@step 附注：同样的办法，求 $\prod\sin$
用例 1.50 的奇数情形（$n$ 换成 $2n-1$）：
$$\frac{x^{2n}-1}{x-1}=1+x+\cdots+x^{2n-1}=(x+1)\prod_{k=1}^{n-1}\Big(x^2-2x\cos\frac{k\pi}n+1\Big).$$
令 $x=1$：左边 $=2n$；右边：$(x+1)=2$，每个二次因式 $=2-2\cos\dfrac{k\pi}n=4\sin^2\dfrac{k\pi}{2n}$。所以
$$2n=2\cdot4^{n-1}\prod_{k=1}^{n-1}\sin^2\frac{k\pi}{2n}\ \Longrightarrow\ \prod_{k=1}^{n-1}\sin^2\frac{k\pi}{2n}=\frac n{4^{n-1}}.$$
所有 $\sin\dfrac{k\pi}{2n}>0$（角在 $(0,\tfrac\pi2)$ 内），开方得 $\displaystyle\prod_{k=1}^{n-1}\sin\frac{k\pi}{2n}=\frac{\sqrt n}{2^{n-1}}$。（$n=1$ 时两边都是 $1$，左边是空积。）
@sum
- 三角函数的连乘，常常可以变成“多项式在某个点的取值”，把 $x^N-1$ 的分解式拿来代入。
- 选点技巧：$x=-1$ 把 $x^2-2x\cos2\theta+1$ 变成 $4\cos^2\theta$，$x=1$ 把它变成 $4\sin^2\theta$。
