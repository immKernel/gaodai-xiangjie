@ex 1.44 19
@prob
设 $F$ 为数域，$f\in F[x]$ 的次数 $n\ge1$。证明：$f'\mid f$ 当且仅当存在 $a,b\in F$，$a\ne0$，使 $f(x)=a(x-b)^n$。
@idea “$\Leftarrow$”直接验证。“$\Rightarrow$”：把 $f$ 做标准分解，每个不可约因式 $p_i$ 在 $f'$ 里恰好少一次，于是 $\gcd(f,f')=\prod p_i^{r_i-1}$。$f'\mid f$ 说明这个 gcd 就是 $f'$，次数 $n-1$，把次数加起来就能推出只有一个一次因式。
@step0 先看一个例子
$f=2(x-3)^4$：$f'=8(x-3)^3$，$f=\dfrac{x-3}{4}\cdot f'$，确实 $f'\mid f$ ✓。
@step “$\Leftarrow$”：$f=a(x-b)^n$ 时
$f'=na(x-b)^{n-1}$，所以
$$f(x)=\frac{x-b}{n}\cdot f'(x).$$
数域里 $\tfrac1n$ 存在（数域的特征为零），$\frac{x-b}{n}\in F[x]$，所以 $f'\mid f$。
@step “$\Rightarrow$”：把 $f$ 做标准分解
设 $f=a\,p_1^{r_1}\cdots p_s^{r_s}$，$p_i$ 是两两不同的首一不可约式，$r_i\ge1$。固定 $i$，记 $f=p_i^{r_i}H_i$，$p_i\nmid H_i$。
@step 每个 $p_i$ 在 $f'$ 里恰好出现 $r_i-1$ 次
$$f'=p_i^{r_i-1}\big(r_ip_i'H_i+p_iH_i'\big).$$
括号里的式子模 $p_i$ 来看，只剩 $r_ip_i'H_i$。$p_i'\ne0$ 且 $\deg p_i'<\deg p_i$，所以 $p_i\nmid p_i'$；$p_i\nmid H_i$，$r_i\ne0$；$p_i$ 不可约，所以 $p_i\nmid r_ip_i'H_i$，括号不被 $p_i$ 整除。
所以
$$\gcd(f,f')=\prod_{i=1}^{s}p_i^{\,r_i-1},\qquad \frac{f}{\gcd(f,f')}=a\prod_{i=1}^{s}p_i.$$
@blocks 例：f=p₁³p₂²。gcd(f,f′) 把每个因式各拿走一块，剩下的就是 p₁p₂
f: p₁ p₁ p₁ p₂ p₂
=gcd(f,f′): p₁ p₁ p₂
=f/gcd: p₁ p₂
@step 用 $f'\mid f$ 数次数
$f'\mid f$，所以 $\gcd(f,f')$ 就是 $f'$（相差常数倍），次数为 $n-1$。于是
$$\sum_i(r_i-1)\deg p_i=n-1,\qquad\sum_ir_i\deg p_i=n.$$
两式相减：
$$\sum_{i=1}^{s}\deg p_i=1.$$
@step 得出结论
每个 $\deg p_i\ge1$，和为 $1$，所以只有一个 $p_1$，且 $\deg p_1=1$，设 $p_1=x-b$。再由 $\sum r_i\deg p_i=n$ 得 $r_1=n$。所以 $f=a(x-b)^n$，$a\ne0$，$b\in F$（$b$ 是 $p_1$ 的系数，属于 $F$）。证毕。
@sum
- $\gcd(f,f')=\prod p_i^{r_i-1}$：每个不可约因式在导数里少一次。
- 次数一加：$\deg f-\deg\gcd(f,f')=\sum\deg p_i$，就是“去重后的次数”。
