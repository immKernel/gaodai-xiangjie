from fractions import Fraction as F
def trim(a):
    while a and a[-1]==0: a.pop()
    return a
def add(a,b):
    n=max(len(a),len(b)); return trim([(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(n)])
def neg(a): return [-x for x in a]
def mul(a,b):
    if not a or not b: return []
    r=[F(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): r[i+j]+=x*y
    return trim(r)
def P(*c): return trim([F(x) for x in c])   # low->high
def pw(a,n):
    r=P(1)
    for _ in range(n): r=mul(r,a)
    return r
X=P(0,1)
# 1.15
f=P(-1,-4,-3,1,1); g=P(-1,-1,1,1)
u=P(F(1,3),F(-2,3)); v=P(F(-4,3),F(-1,3),F(2,3))
print('1.15', add(mul(u,f),mul(v,g)))
# 1.19 m,n
from math import comb
for m in range(1,5):
  for n in range(1,5):
    N=m+n-1; one=P(1); xm=P(0,1); omx=P(1,-1)
    ff=[]; gg=[]
    for k in range(m,N+1): ff=add(ff,mul(P(comb(N,k)),mul(pw(X,k-m),pw(omx,N-k))))
    for k in range(0,m): gg=add(gg,mul(P(comb(N,k)),mul(pw(X,k),pw(omx,m-1-k))))
    assert add(mul(pw(X,m),ff),mul(pw(omx,n),gg))==[F(1)],(m,n)
print('1.19 ok')
# 1.26 identity
import random
for _ in range(20):
    f=P(*[random.randint(-3,3) for _ in range(4)]); g=P(*[random.randint(-3,3) for _ in range(4)])
    u=P(*[random.randint(-3,3) for _ in range(3)]); v=P(*[random.randint(-3,3) for _ in range(3)])
    s=add(f,g); A=add(u,neg(v))
    lhs0=add(mul(u,f),mul(v,g)); lhs=mul(lhs0,lhs0)
    rhs=add(neg(mul(mul(A,A),mul(f,g))),mul(add(mul(mul(u,u),f),mul(mul(v,v),g)),s))
    assert lhs==rhs
print('1.26 ok')
# 1.39
f=P(-2,7,-5,1); h=P(1,-3,1); print('1.39', mul(P(-2,1),h)==f, mul(P(3,1),h)==P(3,-8,0,1))
# 1.40
f=P(8,15-0,0,0)
for p in (4,-5):
    f=P(8,3*p,6,1); fp=P(3*p,12,3)
    print('1.40',p,[x for x in f])
print(mul(pw(P(1,-1),2),P(8,1))==P(8,-15,6,1), pw(P(2,1),3)==P(8,12,6,1))
# 1.16
for k,l in ((2,0),(3,-2)):
    f=P(2*l,2,1+k,1); g=P(l,0,k,1); h=P(l,2,1)
    print('1.16',k,l, mul(h,P(-0 if l==0 else 1,1)) )
print(mul(P(l,2,1),P(1,1))==P(-2,0,3,1) , mul(P(0,2,1),P(0,1))==P(0,0,2,1))
