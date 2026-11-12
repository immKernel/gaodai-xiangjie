@ex 1.15 7
@prob
设 $f(x)=x^4+x^3-3x^2-4x-1,\quad g(x)=x^3+x^2-x-1$。求多项式 $u(x),v(x)$，使 $u(x)f(x)+v(x)g(x)=\gcd(f,g)$，并写出所有这样的 $(u,v)$。
@idea 先用辗转相除求出 $\gcd(f,g)$，再把每一步的余式倒着代回去，就得到 $u,v$。所有解则是“一组特解 $+$ 一个可以自由取的修正项”。
@step0 先用整数感受一遍“辗转相除再回代”
求 $\gcd(18,12)$：
$$18=1\cdot12+6,\qquad 12=2\cdot6+0.$$
最后一个非零余式是 $6$，所以 $\gcd=6$。回代：$6=18-1\cdot12$，即 $6=1\cdot18+(-1)\cdot12$。多项式的做法一模一样，只是“除法”换成多项式除法。
@step 第一次相除：$f$ 除以 $g$
$f$ 的首项 $x^4$ 除以 $g$ 的首项 $x^3$ 得商 $x$。用 $f$ 减去 $x\cdot g$：
$$\begin{aligned}f-xg&=(x^4+x^3-3x^2-4x-1)-(x^4+x^3-x^2-x)\\&=-2x^2-3x-1.\end{aligned}$$
此时次数 $2<3=\deg g$，除法到此为止。记 $r_1=-2x^2-3x-1=-(2x+1)(x+1)$，得
$$f=x\cdot g+r_1.$$
@step 第二次相除：$g$ 除以 $r_1$
先看首项：$x^3\div(-2x^2)=-\tfrac12x$。减去 $-\tfrac12x\cdot r_1=x^3+\tfrac32x^2+\tfrac12x$：
$$g-\big(-\tfrac12x\big)r_1=-\tfrac12x^2-\tfrac32x-1.$$
再看新的首项：$-\tfrac12x^2\div(-2x^2)=\tfrac14$。减去 $\tfrac14r_1=-\tfrac12x^2-\tfrac34x-\tfrac14$：
$$\Big(-\tfrac12x^2-\tfrac32x-1\Big)-\tfrac14r_1=-\tfrac34x-\tfrac34=-\tfrac34(x+1).$$
所以 $g=q_2r_1+r_2$，其中
$$q_2=-\tfrac12x+\tfrac14,\qquad r_2=-\tfrac34(x+1).$$
@step 第三次相除：$r_1$ 除以 $r_2$，余数为 $0$
$r_1=-(2x+1)(x+1)$，而 $x+1=-\tfrac43r_2$，所以
$$r_1=-(2x+1)\cdot\big(-\tfrac43r_2\big)=\big(\tfrac83x+\tfrac43\big)r_2.$$
余式为 $0$，辗转相除结束。最后一个非零余式是 $r_2=-\tfrac34(x+1)$，首一化后
$$\gcd(f,g)=x+1.$$
@step 倒着回代，求出 $u,v$
把第 2 步、第 1 步的等式改写成“余式 $=\cdots$”：
$$r_2=g-q_2r_1,\qquad r_1=f-xg.$$
要的是 $x+1=-\tfrac43r_2$，逐层代入：
$$\begin{aligned}x+1&=-\tfrac43\big(g-q_2r_1\big)=-\tfrac43g+\tfrac43q_2r_1\\&=-\tfrac43g+\tfrac43q_2(f-xg)\\&=\tfrac43q_2\cdot f-\tfrac43\big(1+xq_2\big)\cdot g.\end{aligned}$$
代入 $q_2=-\tfrac12x+\tfrac14$：
$$u_0=\tfrac43q_2=-\tfrac23x+\tfrac13,\qquad v_0=-\tfrac43\Big(1-\tfrac12x^2+\tfrac14x\Big)=\tfrac23x^2-\tfrac13x-\tfrac43.$$
@check 验算：$u_0f+v_0g$ 是否等于 $x+1$
提公分母：$u_0f=\tfrac13(1-2x)f$，$v_0g=\tfrac13(2x^2-x-4)g$。展开：
$$(1-2x)f=-2x^5-x^4+7x^3+5x^2-2x-1,$$
$$(2x^2-x-4)g=2x^5+x^4-7x^3-5x^2+5x+4.$$
两式相加：$x^5,x^4,x^3,x^2$ 项全部抵消，剩 $3x+3$，除以 $3$ 得 $x+1$。✓
@step 所有解：特解 $+$ 修正项
设 $(u,v)$ 是另一组解。两个等式相减：$(u-u_0)f+(v-v_0)g=0$。
因为 $\gcd(f,g)=x+1$，可以写 $f=(x+1)f_0,\ g=(x+1)g_0$，其中（做除法即得）
$$f_0=x^3-3x-1,\qquad g_0=x^2-1.$$
约去 $x+1$：$(u-u_0)f_0=(v_0-v)g_0$。
@why 为什么 $f_0,g_0$ 互素？
$f_0,g_0$ 的公因式乘上 $x+1$ 就是 $f,g$ 的公因式，而 $\gcd(f,g)$ 恰好只有 $x+1$，所以 $f_0,g_0$ 没有非常数的公因式。（直接验证也行：$g_0$ 的根是 $\pm1$，而 $f_0(1)=-3,\ f_0(-1)=1$ 都不为 $0$。）
再用工具 (D)：$g_0\mid(u-u_0)f_0$ 且 $g_0,f_0$ 互素，所以 $g_0\mid u-u_0$，设 $u-u_0=tg_0$。代回去约去 $g_0$ 得 $v_0-v=tf_0$。于是
$$\boxed{u=u_0+t\,g_0,\qquad v=v_0-t\,f_0\quad(t\text{ 为任意多项式})}$$
反过来，这样的 $(u,v)$ 代入后修正项 $tg_0f-tf_0g=t(x+1)(g_0f_0-f_0g_0)=0$，确实是解。
@book 对照：原书的解析（跳过了哪些）
做辗转相除得 $\gcd=x+1$，回代得特解 $u_0=-\tfrac23x+\tfrac13,\ v_0=\tfrac23x^2-\tfrac13x-\tfrac43$。通解把任意一组解与特解相减，约去 $x+1$ 后用互素得到 $u=u_0+tg_0,\ v=v_0-tf_0$。
@sum
- 辗转相除：每一步“上一个除式 $=$ 商 $\times$ 余式 $+$ 新余式”，最后一个非零余式就是 gcd。
- 求 $u,v$：从最后一个等式出发，一层一层把余式换成“上两层的组合”。
- 通解 $=$ 特解 $+$ $t\cdot(g_0,-f_0)$，其中 $f_0=f/\gcd,\ g_0=g/\gcd$。
