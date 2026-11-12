@ex 1.26 12
@prob
设 $f,g\in F[x]$。证明 $\gcd(f,g)=1$ 当且仅当 $\gcd(fg,\ f+g)=1$。
@idea “$\Leftarrow$”是简单的。“$\Rightarrow$”拆成两步：先证 $f+g$ 分别与 $f$、$g$ 互素，再用 [[1.24]]：与两个数都互素就与乘积互素。
@step0 先用数字试试
$f=x,\ g=x+1$：$\gcd(f,g)=1$。$fg=x^2+x,\ f+g=2x+1$，把 $x=-\tfrac12$ 代入 $x^2+x$ 得 $-\tfrac14\ne0$，说明 $2x+1$ 不整除 $x^2+x$，两者互素 ✓。
再看不互素的情形：$f=x,\ g=x^2$：$\gcd=x$；$fg=x^3,\ f+g=x(x+1)$，$\gcd=x\ne1$ ✓（也不互素）。
@step “$\Leftarrow$”：若 $\gcd(fg,f+g)=1$ 则 $\gcd(f,g)=1$
$f,g$ 的任何公因式 $e$ 整除 $fg$，也整除 $f+g$，即是 $fg$ 与 $f+g$ 的公因式，只能是常数。所以 $\gcd(f,g)=1$。
@step “$\Rightarrow$”第一步：$f+g$ 与 $f$ 互素
取 $uf+vg=1$。把 $g$ 写成 $(f+g)-f$：
$$1=uf+v\big((f+g)-f\big)=(u-v)f+v\,(f+g).$$
这是 $f$ 与 $f+g$ 的线性组合等于 $1$，所以 $\gcd(f,f+g)=1$。
@step “$\Rightarrow$”第二步：$f+g$ 与 $g$ 互素
同理把 $f$ 写成 $(f+g)-g$：
$$1=u\big((f+g)-g\big)+vg=u\,(f+g)+(v-u)g,$$
所以 $\gcd(g,f+g)=1$。
@step “$\Rightarrow$”第三步：用 [[1.24]] 合并
[[1.24]] 说：$\gcd(F,\,GH)=1\iff\gcd(F,G)=1$ 且 $\gcd(F,H)=1$。取 $F=f+g,\ G=f,\ H=g$：由前两步，$\gcd(f+g,f)=\gcd(f+g,g)=1$，所以
$$\gcd(f+g,\ fg)=1.$$
证毕。
@book 对照：原书的做法（直接写出等式）
原书取 $uf+vg=1$，令 $s=f+g,\ A=u-v$，则 $Af+vs=1,\ -Ag+us=1$。两式相乘得
$$1=-(u-v)^2fg+(u^2f+v^2g)(f+g),$$
这是 $fg$ 与 $f+g$ 的线性组合。（上面的做法就是把这个计算拆成了两个小步骤 $+$ [[1.24]]。）
@sum
- $\gcd(f,f+g)=\gcd(f,g)$：加上自己的倍数，gcd 不变（也是 [[1.17]] 的特例）。
- 想证“与乘积互素”，先证“与每个因子互素”，再用 [[1.24]]。
