# D言語入門 - 便利な数学関数

このページでは数値計算などをやっていて使いそうな関数のうち、標準ライブラリになさそうであるものを見てみます。 いかにもありそうな e, π, 絶対値 abs, 三角関数 cos, sin, tan, acos, asin, atan, cosh, sinh, tanh, acosh, asinh, atanh, sqrt, cbrt, exp, log, log10, log2 は「ある」とだけ触れておけば大丈夫でしょう。

## std.math.poly

多項式に代入する値と係数の配列をとり、効率よく (多項式の次数に比例した時間で) 計算する関数です。

```d
import std.stdio;
import std.math : poly;

void main()
{
    real[] a = [1,1,1,1]; // 係数は real に限られているので型名を指定する必要がある
    poly(0.5, a).writeln();
}
```

## std.numeric.secantMethod

Secant Method (割線法) は求根アルゴリズムの Newton 法の微分を差分で置き換えたもので、2つの点からスタートします。 2点 (x, f(x)) および (y, f(y)) を結ぶ直線で関数 f を近似し、その根を z として新しい点 (z, f(z)) をとることを繰り返していきます。

関数 f をとり初期値 p, q の Secant Method を以下のように使うことができます。

```d
import std.numeric : secantMethod;
import std.stdio : readln, writefln;
import std.conv : to;
import std.string : strip;

void main()
{
    auto a = readln().strip().to!double();
    "%.15f".writefln(secantMethod!(x => x * x - a)(0.0, a)); // a の平方根を表示
}
```

これを実行して1つの数値を入力すると、その平方根を表示します。

`"%.15f"` というのは、関数 writef, writefln に与えることによって表示形式を指定するものです。 浮動小数点数の場合は `"%.15e"` で指数形式、`"%.15f"` で小数点の位置が固定されます。 15 という数は表示する桁数で、浮動小数点数の精度 (double なら 2進法で 53 bit くらい) より大きく取っても意味がありません。

エクスクラメーションマーク '`!`' の後ろに続く妙な記号列は無名関数とかラムダ式と呼ばれています。 '`=>`' という記号は TeX でいう \mapsto にあたり、`(x => x * x - a)` は「`x` を `x * x - a` へうつす関数」になります。 この関数に対する Secant Method を、初期値 0, a で実行しています。

## std.numeric.Fft

関数を関数へうつすフーリエ変換は6学期の授業をはじめ数学の様々な分野で使われていますが、数列を数列へうつす離散フーリエ変換もさまざまな工学的応用をもちます。 その背景には離散フーリエ変換を小さい計算量で実現する高速フーリエ変換 (FFT) の存在、(連続・離散どちらでも) フーリエ変換が畳み込みを積にうつすことなどが挙げられます。

```d
import std.stdio;
import std.numeric : Fft;
import std.complex;

void main()
{
    auto x = [1,2,1,0];
    auto y = [1,1,0,0];
    auto fft = new Fft(16);
    auto fx = fft.fft(x); // それぞれを
    auto fy = fft.fft(y); // FFT で変換
    "x = %s -> fx = %s".writefln(x, fx);
    "x = %s -> fx = %s".writefln(y, fy);
    writeln();

    Complex!double[] fz;
    foreach (i, a; fx)
    {
        fz ~= a * fy[i]; // 要素ごとの積をとる
    }
    auto z = fft.inverseFft(fz); // そして逆変換
    "x * y = ".writeln(z);
    // 小さな誤差があるが [1,3,3,1] が表示される。畳み込みの計算が成功している。
}
```

表示形式の指定に `"%s"` を使うと「デフォルトの文字列表現」が適用されます。 したがってほとんどのものは `"%s"` としておけば満足です。 このほかの表示形式については他の言語と共通する部分が多いので、ここでは割愛します。

## std.mathspecial.gamma, erf, normalDistribution, normalDistributionInverse

複素解析でおなじみのΓ関数ですが、標準ライブラリに入っているのは実数から実数への関数としてのもののみです。 ぜひ複素数から複素数への関数に拡張してみてください。 normalDistribution および normalDistributionInverse は標準正規分布の累積分布関数および逆です。 erf は normalDistribution のスケールを変えたものです。

```d
import std.stdio : writeln;
import std.mathspecial : gamma, erf, normalDistribution, normalDistributionInverse;

void main()
{
    writeln("Gamma(1/2) = sqrt pi = ", gamma(0.5));
    writeln(`erf(1) = \int_0^1 \exp(-t^2) dt = `, erf(1));
}
```

文字列の中で特殊文字 (たとえばタブ) を使うには `"\t"` のようにします。 これをエスケープシーケンスといいます。 エスケープシーケンスについては他の言語と共通する部分が多いので、ここでは割愛します。 ただし、改行文字 `"\n"` はエスケープシーケンスにしなくてもよいということだけは言っておかなければならないでしょう。

この影響で、記号 `\` を文字列の中に直接は書けないという問題があります。 `"\\"` とすればよいのですが、他の方法もあります。 それが上のコード例で、バッククオートでくくられた文字列の中ではエスケープシーケンスが解釈されません。
