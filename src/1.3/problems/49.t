@ex 1.49 21
@prob
设 $1,\omega_1,\dots,\omega_{n-1}$ 是 $x^n-1$ 的全部相异复根。证明
$$\prod_{j=1}^{n-1}(1-\omega_j)=n.$$
@idea 同一个多项式 $x^n-1$ 有两种分解：按根分解，和等比和分解。两种写法约去 $x-1$ 后令 $x=1$ 就得到结论。几何上，$|1-\omega_j|$ 就是点 $1$ 到点 $\omega_j$ 的距离。
@step0 先算 $n=3$
$\omega_{1,2}=\dfrac{-1\pm\sqrt3\,i}{2}$，满足 $\omega_1+\omega_2=-1,\ \omega_1\omega_2=1$。
$$(1-\omega_1)(1-\omega_2)=1-(\omega_1+\omega_2)+\omega_1\omega_2=1+1+1=3=n\ ✓$$
@step 写出 $x^n-1$ 的两种分解
按根分解（$n$ 个相异根，首一）：
$$x^n-1=(x-1)\prod_{j=1}^{n-1}(x-\omega_j).$$
按等比和分解（工具 (F3)）：
$$x^n-1=(x-1)\,(1+x+x^2+\cdots+x^{n-1}).$$
@step 约去 $x-1$
两个等式的左边相同，约去非零因子 $x-1$：
$$\prod_{j=1}^{n-1}(x-\omega_j)=1+x+x^2+\cdots+x^{n-1}.$$
这是多项式恒等式，对任何 $x$ 都成立。
@step 令 $x=1$
左边变成 $\prod(1-\omega_j)$；右边是 $n$ 个 $1$ 相加，等于 $n$。所以
$$\prod_{j=1}^{n-1}(1-\omega_j)=n.\qquad\text{证毕。}$$
@roots n=6：从点 1 出发，向其他 5 个单位根各连一条线（弦），5 条弦长的乘积正好等于 6
n 6
from 1 0
@why 几何意义（选读）
$|1-\omega_j|$ 是弦长。当 $\omega_j=e^{2\pi ij/n}$ 时，弦长 $=2\sin\dfrac{\pi j}{n}$。所以结论的另一种写法是
$$\prod_{j=1}^{n-1}2\sin\frac{\pi j}n=n,\quad\text{即}\ \ \prod_{j=1}^{n-1}\sin\frac{\pi j}{n}=\frac n{2^{n-1}}.$$
@sum
- 同一个多项式的两种分解，约去公共因子后“代一个好算的点”，是求根的乘积/和的常用办法。
- $x^n-1$ 的根在单位圆上均匀分布，是 1.3 节后半的主角。
