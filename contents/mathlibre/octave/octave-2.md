# Octave入門続編

[Octave入門](octave.md)に引き続き，Octaveへの駆け足の入門を行う．

## Tips

* `%` または `#` から行末まではコメント．
* 変数などの名前は大文字小文字を区別する．
* 行末にピリオド"`.`"を3個続けて書くと次の行への継続になる．
* 変数代入や演算後の表示の制御は次のとおり．

```octave
> a = 1
> a + 1;
> disp(a + 2)
```

* ヘルプは"`help`"の後に名前

```octave
> help help
> help rank
```

* セミコロン"`;`"やコンマ"`,`"を使って一行の中に複数のコマンドが書ける

```octave
> a = 1; b = 2, c = 3           % 見え方の違いは何によるか
```

* キーボード入力中，上向き矢印キーor Ctrl-Pで過去に入力したコマンドを呼び出すなどの編集コマンドが使える．

## 制御構造

### if文

```octave
> x = -1;
> if x < 0
>  x = -x;
> end
```

else, elseifも使える

```octave
> x = -1;
> if x < 0
>    y = sqrt(-x);
> elseif x == 0
>    y = 1;
> else
>    y = sqrt(x);
> end
```

### forループ

決まった回数繰り返しをする時．
変数の範囲をベクトルで与えることに注意．

```octave
> s = 0;
> for i = 1:10
>   s = s + i;
> end
```

刻み幅を変えることもできる．

```octave
> s = 0;
> for i = 1:2:10
>   s = s + i     % セミコロンをつけないでおくと途中の動作が分かる
> end
```

負の刻み幅も．

```octave
> s = 0;
> for i = 10:-1:1
>   s = s + i
> end
```

### whileループ

条件が成り立つ間ループするという場合．

```octave
> p=0.1; n = 0;
> while rand() > p    % rand()は乱数を返す
>   n = n + 1;
> end
```

これを何度も繰り返す場合，

```octave
> p=0.1; n=0; while rand()>p; n=n+1; end; n
```

と一行に書いてしまって，
上向き矢印キーで何度も呼び出して実行すると簡単．

### switch文

変数のとる値によって処理を変える場合，if文を使うと入れ子になってみにくくなることがある．そのようなときはswitch文を使うとよい．

```octave
> x = 1;
> switch x
>   case 0
>     y = 2;
>   case 1
>     y = -1;
>   case -1
>     y = 1;
>   otherwise
>     y = 2;
> end
```

（Cを知っている人へ：break不要）

### 処理の飛び越し

ループ内で処理を中断し，すぐ次のループに移る時 `continue` を使う．

```octave
> p = 0.1; n = 0;
> for i = 1:1000
>   if rand() > p
>     continue
>   end
>   n = n + 1;
> end
```

ループ内で処理を中断し，すぐループを抜けるときは `break` を使う．

```octave
> p = 0.1; n = 0;
> for i = 1:1000
>   if rand() < p
>     break
>   end
>   ++n;
> end
```

## 文字列

文字列は `'...'` で囲む．

```octave
> c = 'thank you';
> disp(c)
```

文字列の連結は `strcat()`.

```octave
> d = strcat(c, ' very much');
> d = strcat(c, ' ', 'very much');    # これでもよい
```

その他文字列を扱う関数が用意されている．詳細はrefcardを見よ．

## グラフィックス

### 2D

`plot` コマンドを使って簡単にグラフを描くことができる．

```octave
> x = pi * (-1:0.01:1);
> plot(x, sin(x));
```

片対数のグラフも描ける．

```octave
> x = -4:0.01:4;
> y = 1/sqrt(2 * pi) * exp( -x .^2 /2);    # .^ はベクトルの要素ごとのべき
> plot(x, y);
> semilogy(x, y);
```

もちろん両対数も．

```octave
> x = 0:0.01:10;
> alpha = 2.3;
> y = x.^(-alpha);          # power-law
> plot(x,  y);
> loglog(x, y);
```

パラメータ表示．

```octave
> t = 0:0.01:4*pi;
> plot(t .* cos(t), t .* sin(t));     # .* は要素ごとの積
```

### 3D

単純な曲線を描くには `plot3` を使う．

```octave
> t = 0:0.01:6*pi;
> plot3(t + cos(t), t .* sin(t), t);
```

面を描くには `mesh` コマンドを使うが，
少し準備がいる．

```octave
> t = linspace(0, 10, 40);      # [0, 10] を40に分ける分点を生成
> [x, y] = meshgrid(t, t);      # X, Y座標を生成
> z = sin(x) + cos(y/2);        # Z座標を生成
> mesh(x, y, z);
```

グラフの色やマーカやラベルを変えるコマンドがいろいろ用意されているので試してみるとよい．

## お疲れさま

余力のあるひとは「[Octave数値シミュレーション入門](octave-3.md)」にすすんでください．

実習の材料の多くは

* 櫻井鉄也，『MATLAB/Scilabで理解する数値計算』（東京大学出版会）

からの引用です．
