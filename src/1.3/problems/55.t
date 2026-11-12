@ex 1.55 23
@prob
设 $f,g\in\mathbb R[x]$，$f\ne0$，$\deg g<\deg f$。证明 $g/f$ 可分解为部分分式
$$\frac{g(x)}{f(x)}=\sum_{i=1}^{m}\sum_{h=1}^{e_i}\frac{b_{i,h}}{(x-a_i)^h}+\sum_{j=1}^{n}\sum_{k=1}^{r_j}\frac{c_{j,k}x+d_{j,k}}{(x^2+s_jx+t_j)^k},$$
其中 $x-a_i$ 与 $x^2+s_jx+t_j$ 分别是 $f$ 在 $\mathbb R[x]$ 中的首一一次与二次不可约因式，$e_i,r_j$ 为相应指数。
@idea 这是“部分分式分解”的存在性。分三步：①把 $f$ 的分母“拆开”，写成 $g=\sum U_iF_i$（用多个多项式互素的裴蜀等式）；②用 $P_i$ 做带余除法把分子压到次数 $<\deg P_i$；③再按 $p_i$ 的幂逐层展开。
@step0 先看一个具体例子
$\dfrac{x}{(x-1)(x^2+1)}=\dfrac{a}{x-1}+\dfrac{bx+c}{x^2+1}$。通分：$x=a(x^2+1)+(bx+c)(x-1)$。取 $x=1$：$1=2a$，$a=\tfrac12$。比较 $x^2$ 系数：$0=a+b$，$b=-\tfrac12$。比较常数项：$0=a-c$，$c=\tfrac12$。核对：$\tfrac12(x^2+1)+(-\tfrac12x+\tfrac12)(x-1)=\tfrac12x^2+\tfrac12-\tfrac12x^2+x-\tfrac12=x$ ✓。
@step 把 $f$ 拆成 $P_i$，再看 $F_i=f/P_i$
$g=0$ 时取全零。设 $g\ne0$，把 $f$ 的标准分解写成 $f=c\prod_{i=1}^{\ell}p_i^{v_i}$，$p_i$ 是不同的首一不可约式（一次或二次）。令
$$P_i=p_i^{v_i},\qquad F_i=\frac f{P_i}\ (\text{去掉第 }i\text{ 个因式后剩下的})\,.$$
@blocks 例：f=P₁P₂P₃。三个 F_i 各缺一块，三者没有公共块，所以 gcd(F₁,F₂,F₃)=1
F₁: P₂ P₃
F₂: P₁ P₃
F₃: P₁ P₂
=f: P₁ P₂ P₃
@step $F_1,\dots,F_\ell$ 的公因式只有常数
若不可约式 $r$ 整除所有 $F_i$，则 $r$ 整除 $f$，所以 $r$ 是某个 $p_j$。但 $F_j$ 里已经去掉了 $p_j$，$r=p_j$ 不整除 $F_j$，矛盾。所以 $\gcd(F_1,\dots,F_\ell)=1$。
由多个多项式互素的裴蜀等式（[[1.29]] 的推广：逐个合并），存在 $V_i$ 使
$$\sum_{i=1}^{\ell}V_iF_i=1.$$
两边乘 $g$，令 $U_i=gV_i$：$g=\sum_iU_iF_i$。
@step 用 $P_i$ 做带余除法，压小分子
$U_i=Q_iP_i+R_i$，$R_i=0$ 或 $\deg R_i<\deg P_i$。代入：
$$g=\sum_i(Q_iP_i+R_i)F_i=f\sum_iQ_i+\sum_iR_iF_i.$$
@step 证明 $\sum Q_i=0$
移项：$g-\sum R_iF_i=f\sum Q_i$。左边每一项的次数都 $<\deg f$（$\deg g<\deg f$，$\deg(R_iF_i)<\deg P_i+\deg F_i=\deg f$），所以左边次数 $<\deg f$。右边若 $\sum Q_i\ne0$，次数 $\ge\deg f$。所以 $\sum Q_i=0$，于是
$$\frac gf=\sum_{i=1}^{\ell}\frac{R_iF_i}{f}=\sum_{i=1}^{\ell}\frac{R_i}{p_i^{v_i}}.$$
@step 把 $R_i$ 按 $p_i$ 的幂展开
对每个 $i$，用 $p_i$ 反复做带余除法（先 $R_i=p_iS_1+A_0$，再 $S_1=p_iS_2+A_1$，……）。每次余式次数 $<\deg p_i$，商的次数每次至少降 $\deg p_i$，而 $\deg R_i<v_i\deg p_i$，所以至多做 $v_i$ 次商就变成零：
$$R_i=A_{i,0}+A_{i,1}p_i+\cdots+A_{i,v_i-1}p_i^{v_i-1},\qquad\deg A_{i,j}<\deg p_i.$$
@step 除以 $p_i^{v_i}$，得到每一项
$$\frac{R_i}{p_i^{v_i}}=\sum_{j=0}^{v_i-1}\frac{A_{i,j}}{p_i^{\,v_i-j}}.$$
$p_i$ 是一次式时 $\deg A_{i,j}<1$，$A_{i,j}$ 是常数；$p_i$ 是二次式时 $\deg A_{i,j}<2$，$A_{i,j}=cx+d$。分别相加，就得到题设的分解。证毕。
@flow 证明路线
[a]g/f -{拆 f 为 P_i，Bezout}> [b]g = ΣU_iF_i -{U_i=Q_iP_i+R_i}> [b]g/f = ΣR_i/P_i -{按 p_i 的幂展开}> [c]Σ A_{i,j}/p_i^{v_i−j}
@sum
- 部分分式分解的三板斧：互素拆分母 $\to$ 带余除法压分子 $\to$ 按幂展开。
- 实数域上，不可约因式只有一次式和二次式，所以分子是常数或 $cx+d$。
