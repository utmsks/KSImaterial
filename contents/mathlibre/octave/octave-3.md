# Octave数値シミュレーション入門

Octaveで常微分方程式の初期値問題をlsodeという専用のソルバを用いて、数値的に解いてみよう。

## 例: 調和振動子

```octave
> function xdot=f(x,t)
> xdot(1)=x(2)
> xdot(2)=-x(1)
> endfunction
> x0=[1; 0];
> t=linspace(0,10,50);
> x=lsode("f", x0, t);
```

(いろいろ出力されるが `q` を押す)

```octave
> plot(x, t)
> plot(x(:,1),x(:,2))
```

### 外力項つき

```octave
> function xdot=f(x,t)
> omega = 0.5
> xdot(1)=x(2)
> xdot(2)=-x(1)+sin(omega*t)
> endfunction
> x0=[1; 0];
> t=linspace(0,10,50);
> x=lsode("f", x0, t);
```

(いろいろ出力されるが `q` を押す)

```octave
> plot(x, t)
```

問：`omega` を1にしてみる(共鳴状態)

## 演習

### 単振り子

$\frac{d^2 \theta}{dt^2} = - \sin \theta$
初期値$\theta(0)$の値によって軌道がどう変わるか。

### Van del Pol方程式

$\frac{d^2 x}{dt^2} = k (1-x^2) \frac{dx}{dt} - x$
$k$の値によって軌道がどう変化するか
右辺に外力項$\sin \omega t$を加えるとどうなるか。$\omega$を適当に変化させてみる

### Lorenz方程式

$\frac{dx}{dt} = \sigma ( - x + y )$
$\frac{dy}{dt} = -x z + r x - y$
$\frac{dz}{dt} = x y -b z$

$ ( \sigma, r, b ) $の値によって軌道がどう変わるか(有名なのは$ ( 10, 28, 8/3 ) $)

## 時間があまったら

以下の問題を自分で微分方程式を立てて解いてみよう。

* 振り子を二重、三重にしてみる。
* 振り子を三次元で動かしてみる。
* N個の物体が万有引力で相互作用しながら運動する(N体問題、とりあえずN=2,3あたりから)

## Thanks

この課題は2009年度RA中田君が作成してくれました。
