@ex 1.31 14
@prob
设 $\varphi\in\mathbb Q[x]$ 不可约，$x_1,\dots,x_s$ 是它的全部复根。若 $f\in\mathbb Q[x]$ 且 $\varphi\nmid f$，证明存在 $h\in\mathbb Q[x]$，使
$$h(x_i)=\frac1{f(x_i)},\qquad i=1,\dots,s.$$
@idea “$h(x_i)=1/f(x_i)$”就是“$h(x_i)f(x_i)=1$”。构造 $hf+g\varphi=1$ 的裴蜀等式，再代入根 $x_i$——因为 $\varphi(x_i)=0$，含 $\varphi$ 的那项就消失了。
@step0 先看一个例子
$\varphi=x^2-2$（在 $\mathbb Q$ 上不可约），根为 $\pm\sqrt2$；$f=x+1$。$f(\sqrt2)=\sqrt2+1$，倒数是 $\sqrt2-1$；$f(-\sqrt2)=1-\sqrt2$，倒数是 $-(1+\sqrt2)$。
取 $h=x-1$：$h(\sqrt2)=\sqrt2-1$ ✓，$h(-\sqrt2)=-\sqrt2-1$ ✓。而 $hf=x^2-1=1+\varphi$，所以 $hf-\varphi=1$，正是裴蜀等式。
@step 先证明 $\gcd(f,\varphi)=1$
$\varphi$ 不可约，它的首一因式只有 $1$ 和它自己的首一化 $\varphi_0$。$\gcd(f,\varphi)$ 是 $\varphi$ 的首一因式，所以只能是 $1$ 或 $\varphi_0$。若是 $\varphi_0$，则 $\varphi_0\mid f$，即 $\varphi\mid f$，与题设矛盾。所以 $\gcd(f,\varphi)=1$。
@step 裴蜀等式，再代入根
有 $h,g\in\mathbb Q[x]$ 使
$$h(x)f(x)+g(x)\varphi(x)=1.$$
这是多项式恒等式，对任意复数 $x$ 都成立。代入 $x=x_i$，因为 $\varphi(x_i)=0$：
$$h(x_i)f(x_i)=1.$$
@step 得出结论
上式说明 $f(x_i)\ne0$（否则左边为 $0$），可以两边除以 $f(x_i)$：$h(x_i)=\dfrac1{f(x_i)}$。证毕。
@why 为什么 $h$ 还是有理系数？
裴蜀等式是在 $\mathbb Q[x]$ 里做的辗转相除，所有系数都是有理数。根 $x_i$ 虽然可能是无理数或复数，但只是把它“代入”，不影响 $h$ 的系数。
@sum
- “不可约 + 不整除 $\Rightarrow$ 互素”是联系不可约与互素的桥梁。
- “求倒数”就是“凑 $hf=1$ 并在根处消掉 $\varphi$”。这是后面构造 $\mathbb Q(\sqrt2)$ 等域的核心思想。
