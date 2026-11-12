@ex 1.38 18
@prob
设 $d(x),f(x),g(x),h(x)\in K[x]$ 满足
$$\gcd\!\Big(\frac{g(x)}{\gcd(f(x),g(x))},\ h(x)\Big)=d(x),\qquad p(x)=\gcd\big(f(x),d(x)\big).$$
若 $\deg p\ge1$，证明 $g(x)$ 有重因式。
@idea 要证 $g$ 有重因式，只要证 $g$ 被某个不可约式 $r$ 的平方整除。思路：$p$ 同时“藏”在 $q=\gcd(f,g)$ 里和 $d$ 里，而 $g=q\cdot d\cdot(\text{别的})$，所以 $p$ 在 $g$ 里至少出现两次。
@step0 先看一个具体例子
$f=x,\ g=x^2(x+1),\ h=x$。$q=\gcd(f,g)=x$，$g/q=x(x+1)$，$d=\gcd(x(x+1),x)=x$，$p=\gcd(f,d)=x$，次数是 $1$。而 $g=x^2(x+1)$ 确实有重因式 $x$ ✓。
@step 设 $q=\gcd(f,g)$，把 $g$ 写成 $q\cdot d\cdot g_1$
$d$ 是 $g/q$ 与 $h$ 的公因式，所以 $d\mid g/q$，写 $g/q=d\,g_1$。于是
$$g=q\cdot d\cdot g_1.$$
@step 证明 $p\mid q$
$p=\gcd(f,d)$，所以 $p\mid f$，且 $p\mid d$。而 $d\mid g/q\mid g$，故 $p\mid g$。
于是 $p$ 同时整除 $f$ 和 $g$，它是 $f,g$ 的公因式，必整除最大公因式 $q$：$p\mid q$。写 $q=pq_1$。
@step 把 $p$ 的两次出现找出来
又 $p\mid d$，写 $d=pd_1$。代回 $g=qdg_1$：
$$g=(pq_1)(pd_1)g_1=p^2\,q_1d_1g_1.$$
@blocks p 同时藏在 q 里和 d 里，所以 g 里至少有两个 p 块
q: p q₁
d: p d₁
=g: p q₁ p d₁ g₁
legend a q 与 d 的公共块 p
@step 得出重因式
$\deg p\ge1$，所以 $p$ 有一个不可约因式 $r$。由 $p^2\mid g$ 得 $r^2\mid g$。即 $g$ 有重因式 $r$。证毕。
@sum
- “$p$ 整除 $f$，又整除 $g/\gcd(f,g)$ 的某个因子”这种情形，说明 $p$ 在 $g$ 中至少出现两次：一次在 $\gcd$ 里，一次在 $g/\gcd$ 里。
- 证明有重因式：找出 $r^2\mid g$。
