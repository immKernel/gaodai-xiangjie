@ex 1.39 18
@prob
求 $a,b$，使 $f(x)=x^3-5x^2+7x+a$ 和 $g(x)=x^3-8x+b$ 有两个公共根。
@idea 两个三次多项式有两个公共根 $\gamma,\delta$，就都含有二次因子 $h=(x-\gamma)(x-\delta)$：$f=(x-\alpha)h$，$g=(x-\beta)h$。设 $h=x^2+sx+u$，然后比较系数。
@step0 先看图：两条三次曲线要在 x 轴上“共用”两个交点
下面是答案 $a=-2,\ b=3$ 时的两条曲线，它们都经过 x 轴上同样的两个点（也就是两个公共根）。
@plot f 与 g 在 x 轴上有两个相同的零点 x=(3−√5)/2≈0.38 和 x=(3+√5)/2≈2.62
x -3.5 4.5
y -16 16
fn x^3-5*x^2+7*x-2 | f
fn x^3-8*x+3 | g | dash
pt 0.381966 0 | 0.38
pt 2.618034 0 | 2.62
@step 设公共根对应的二次因式，写出 $f,g$ 的形状
设公共根为 $\gamma,\delta$，$h(x)=(x-\gamma)(x-\delta)=x^2+sx+u$。$f,g$ 都是首一三次式，各自还剩一个一次因式：
$$f=(x-\alpha)h,\qquad g=(x-\beta)h.$$
@step 用 $g-f$ 求出 $h$ 的 $x$ 项系数
两式相减，右边提出 $h$：
$$g-f=(x^3-8x+b)-(x^3-5x^2+7x+a)=5x^2-15x+(b-a)=(\alpha-\beta)\,h.$$
$g-f$ 是二次式，比较 $x^2$ 的系数：$\alpha-\beta=5$。于是
$$h=\frac{5x^2-15x+(b-a)}{5}=x^2-3x+u,\qquad u=\frac{b-a}{5}.$$
@step 用 $f=(x-\alpha)h$ 比较系数，解出 $\alpha,u,a$
展开 $(x-\alpha)(x^2-3x+u)=x^3-(\alpha+3)x^2+(3\alpha+u)x-\alpha u$，与 $f=x^3-5x^2+7x+a$ 比较：
$$\alpha+3=5,\qquad 3\alpha+u=7,\qquad -\alpha u=a.$$
解得 $\alpha=2,\ u=1,\ a=-2$。
@step 再求 $b$
$\beta=\alpha-5=-3$，$u=(b-a)/5=1$，所以 $b=a+5u=-2+5=3$。答案：
$$\boxed{a=-2,\quad b=3}.$$
@check 验算：两个多项式确实有公共的二次因式
$f=x^3-5x^2+7x-2=(x-2)(x^2-3x+1)$（展开：$x^3-3x^2+x-2x^2+6x-2$ ✓）。
$g=x^3-8x+3=(x+3)(x^2-3x+1)$（展开：$x^3-3x^2+x+3x^2-9x+3$ ✓）。
公共的 $x^2-3x+1$ 的判别式 $=9-4=5>0$，有两个相异的根 $\dfrac{3\pm\sqrt5}{2}$，正是图中的两个点。
@book 对照：原书的做法
原书同样做差，再用 $f-(x-2)h$ 的次数 $\le1$ 来确定 $\alpha=2$。本题上面直接比较 $x^2$ 项的系数，更短。
@sum
- “两个多项式有 $k$ 个公共根” $\Rightarrow$ 都含 $k$ 次公因式；设出这个公因式，再比较系数。
- 做差能把次数压低，一下子看出 $\alpha-\beta$。
