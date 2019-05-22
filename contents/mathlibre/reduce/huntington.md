# Huntington代数(REDUCE)

## Huntington代数

$a, b \in \mathbb{R}$ に対して次のように和$\oplus$と積$\otimes$を定義する。
$a \oplus b = a + b + 1$,
$a \otimes b = ab + a + b$.

REDUCEでは

```
operator wa, seki;
for all x, y let
wa(x, y) = x + y + 1,
seki(x, y) = x*y + x + y;
```

## 結合則が成り立つこと

```
wa(a, wa(b, c)) - wa(wa(a, b), c);
seki(a, seki(b, c)) - seki(seki(a, b), c);
```

## 単位元

```
let zero = -1, unit = 0;
wa(x, zero);
seki(x, unit);
```

## 逆

```
for all x let
neg(x) = -x - 2,
inv(x0 = -x/(x+1);
wa(x, neg(x)) - zero;
seki(x, inv(x)) - unit;
```

## 演習

(1)
$a \oplus a = 2 \otimes a$ は成り立つか？

(2)
分配則
$a \otimes (b \oplus c) = (a \otimes b) \oplus (a \otimes c)$
を確かめよ。

(3)
分数の計算
$1/a \otimes 1/b = (a \oplus b) / (a \otimes b)$
を確かめよ。

---

広田良吾「REDUCE 3.1による数式処理の例題と演習」
（後藤英一他編『計算機による数式処理のすすめ』所収）からの引用です。

