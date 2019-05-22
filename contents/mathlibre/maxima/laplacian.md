# Laplacian (Maxima)

２次元のLaplacianを直交座標から極座標に変換する。
$x = r cos p, y = r sin p$

宣言

```
depends(u, [r,p], r, [x,y], p, [x,y]);
```

chain rule

```
diff(u,x);
```

$\frac{\partial r}{\partial x} = cos p$, $\frac{\partial p}{\partial x} = - \frac{sin p}{r}$ を代入

```
subst(cos(p),diff(r,x),%);
```

$\frac{\partial u}{\partial x}$を得る

```
dux:subst(-sin(p)/r, diff(p,x), %);
```

同様にして$\frac{\partial^2 u}{\partial x^2}$を得る

```
diff(dux,x);
subst(cos(p), diff(r,x), %);
subst(-sin(p)/r,diff(p,x),%);
duxx:expand(%);
```

以下同様

```
diff(u,y);
subst(sin(p), diff(r,y),%);
duy:subst(cos(p)/r, diff(p,y),%);
diff(duy,y);
subst(sin(p), diff(r,y), %);
subst(cos(p)/r, diff(p,y), %);
uyy:expand(%);
```

やっと$\Delta u$に到達

```
duxx + duyy;
```

三角関数を簡単化するにはもう一息

```
trigreduce(%);
```

**課題**

３次元でやってみる。

---

『数式処理　入門から高度利用まで』より引用
