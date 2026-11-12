@ex 1.24 12
@prob
证明：$\gcd(f,gh)=1$ 当且仅当 $\gcd(f,g)=1$ 且 $\gcd(f,h)=1$。
@idea 全靠工具 (A)：“互素 $\iff$ 能凑出 $1$”。“$\Leftarrow$”把两个等式“$1\times1=1$”乘起来；“$\Rightarrow$”把 $gh$ 拆开看。
@step0 先用数字感受
$f=x$，$g=x+1$，$h=x-1$：$f$ 与 $g$ 互素，$f$ 与 $h$ 互素，$gh=x^2-1$ 也与 $x$ 互素 ✓。换成 $g=x$ 就不互素了，此时 $gh=x(x-1)$ 与 $f=x$ 也不互素 ✓。
@step 方向一（$\Leftarrow$）：由两个等式乘出 $1$
已知 $\gcd(f,g)=1$ 和 $\gcd(f,h)=1$，各取一个裴蜀等式：
$$pf+qg=1,\qquad uf+vh=1.$$
两个“$1$”相乘还是 $1$：
$$1=(pf+qg)(uf+vh)=puf^2+pvfh+quf g+qv\,gh.$$
@step 把含 $f$ 的项合并
前三项都含因子 $f$，提出来：
$$1=f\cdot(puf+pvh+qug)+(qv)\cdot(gh).$$
这是 $f$ 与 $gh$ 的一个线性组合等于 $1$，由工具 (A)，$\gcd(f,gh)=1$。
@step 方向二（$\Rightarrow$）：把 $gh$ 拆开
已知 $\gcd(f,gh)=1$，有 $uf+v\,gh=1$。同一个等式可以有两种看法：
$$uf+(vh)\cdot g=1\quad\Longrightarrow\quad\gcd(f,g)=1,$$
$$uf+(vg)\cdot h=1\quad\Longrightarrow\quad\gcd(f,h)=1.$$
证毕。
@sum
- 证互素，就凑出“线性组合 $=1$”；用互素，就取出这样的等式。
- 两个“$=1$”的等式相乘，是证明“与一个乘积互素”的标准手法。
- 本题常用形式：$f$ 与 $g_1,g_2,\dots,g_k$ 都互素 $\Rightarrow$ $f$ 与乘积 $g_1\cdots g_k$ 互素。
