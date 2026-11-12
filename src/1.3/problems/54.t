@ex 1.54 23
@prob
设 $f,g\in F[x]$（$F$ 为数域）。证明 $f\mid g$ 当且仅当对任意整数 $n>1$ 都有 $f^n\mid g^n$。
@idea “$\Rightarrow$”直接取 $n$ 次幂。“$\Leftarrow$”：用标准分解，比较每个不可约因式的指数。$f^n\mid g^n$ 说明每个因式在 $f^n$ 里的指数 $nr_j$ 不超过在 $g^n$ 里的指数 $nt_j$，约去 $n$ 得到 $r_j\le t_j$。
@step0 先看一个例子
$f=x^2(x+1)$，$g=x^3(x+1)^2(x-2)$。$f\mid g$ ✓。$n=2$：$f^2=x^4(x+1)^2$，$g^2=x^6(x+1)^4(x-2)^2$，$f^2\mid g^2$ ✓。指数比较：$4\le6,\ 2\le4$。
@step “$\Rightarrow$”：取 $n$ 次幂
$f\mid g$，写 $g=fh$。两边取 $n$ 次幂：$g^n=f^nh^n$，所以 $f^n\mid g^n$。
@step “$\Leftarrow$”：设某个 $n>1$ 使 $f^n\mid g^n$，先处理零的情形
若 $g=0$：$f\mid0$ 总成立。若 $f=0$（此时 $f^n=0\mid g^n$ 迫使 $g=0$），两边都等价于 $g=0$。以下设 $f,g\ne0$。
@step 把 $f,g$ 的标准分解写成同一组不可约因式
把在 $f$ 或 $g$ 中出现的全部首一不可约因式列为 $p_1,\dots,p_s$（允许指数为 $0$）：
$$f=a\prod_{j=1}^{s}p_j^{r_j},\qquad g=b\prod_{j=1}^{s}p_j^{t_j}.$$
@step 用唯一分解比较指数
$f^n=a^n\prod p_j^{nr_j}$，$g^n=b^n\prod p_j^{nt_j}$。$f^n\mid g^n$ 且分解唯一，所以对每个 $j$：$nr_j\le nt_j$。因为 $n>0$：
$$r_j\le t_j.$$
@bars 例：f=x²(x+1)，g=x³(x+1)²(x−2)。每个因式在 fⁿ 里的指数 n·r_j 都不超过 n·t_j（图中 n=2）
x 在 f 中 | 4 | a | 2r₁ = 4
x 在 g 中 | 6 | c | 2t₁ = 6
(x+1) 在 f 中 | 2 | a | 2r₂ = 2
(x+1) 在 g 中 | 4 | c | 2t₂ = 4
@step 得出 $f\mid g$
$$g=f\cdot\Big(\frac ba\prod_{j=1}^{s}p_j^{\,t_j-r_j}\Big).$$
括号里每个指数 $t_j-r_j\ge0$，所以括号是 $F[x]$ 中的多项式。故 $f\mid g$。证毕。
@sum
- 整除 $\iff$ 标准分解里每个因式的指数 $\le$：这是处理“幂的整除”的标准办法。
- 取幂把指数乘上 $n$，不等号方向不变，所以可以约去 $n$。
