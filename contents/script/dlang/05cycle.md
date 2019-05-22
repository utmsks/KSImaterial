# D言語入門 - 巡回置換分解

少し趣向を変えて、具体的な問題に取り組むことにしましょう。 ここでは、[Python入門](../python/intro2013.md)の例題「置換を巡回互換の積に分解する」を解くことにします。 置換を表すには key と value に同じ型をもつ連想配列が適しています。 幸いにしてD言語にも連想配列の型は組み込まれており、キーの型が K, 値の型が V であれば V[K] となります。 また、中身を与える記法で `auto aa = [0:0, 1:2, 2:1, 3:4, 4:5, 5:3]` のように初期化することができます。 明示的に初期化しなければ空になっています。

巡回置換を表す標準的なデータ構造はないと思いますが、移る先を順に並べた配列で十分でしょう。 したがって戻り型は配列の配列にするのが適当です。 それでは、コードを書き始めましょう。

```d
T[][] decompose(T)(T[T] permutation)
{
    // うーん・・・
}
```

プログラムを簡潔にまとめるコツの1つに、問題を部分問題へ分割するというものがあります。 数学と一緒ですね。 連想配列がキー集合上の置換であるとき (i.e., キー集合と値集合が等しいとき)、そこから任意の巡回置換を取り除いてもこの性質は保たれます。 したがって

* 巡回置換を取り除くことができないことを判定する方法
* 巡回置換を取り除くことができる場合に、取り除く方法

が部分問題となります。

まず前者ですが、これは空集合上の置換になっているときです。 巡回置換 0 個に分解されることが明らかですね。 プログラムの言葉に直すと、空の連想配列が与えられたら配列の空の配列を返すことになります。 連想配列が空であるかどうかは、大きさ `.length` を 0 と比較すれば判定できます。 これが数学的帰納法の initial step になります。

```d
if (permutation.length == 0)
    return [];
```

次に後者を考えます。 空でないことがわかったので、任意に要素をとります。 これは少しトリッキーですが、`.byKey()` の先頭 `.front` によって実現します。 このキーがどこへ移るかを見ながら、キーはサイクルの一部として保存しつつ、連想配列からは削除します。

```d
cycle ~= k; // サイクルへ記録
auto v = permutation[k]; // 値をとる
permutation.remove(k); // キーを削除
```

この値に対して同様の処理を行えばよいでしょう。 値をとれなくなったら「すでに削除されてしまった要素を参照した」ことになるので、サイクルへ記録する前に中断する必要があります。 制御構造は while 文、in 演算子を使って実現できます。

```d
while (k in permutation) // 連想配列に含まれているキーを参照している間
{
    cycle ~= k;
    auto v = permutation[k];
    permutation.remove(k);
    k = v; // 次へ進む前に k を書き変える
}
```

cycle は変数名の通り、1つの巡回置換を保存しておくための配列で、空に初期化 (つまり、宣言だけ) しておきます。 while の条件が崩れたら cycle は完成し、残りは縮小された permutation の分解に還元されます。 数学的帰納法の inductive step ですね。

それでは、コード全体を見てみます。

```d
T[][] decompose(T)(T[T] permutation)
{
    if (permutation.length == 0)
        return [];
    auto k = permutation.byKey().front;
    T[] cycle;
    while (k in permutation)
    {
        cycle ~= k;
        auto v = permutation[k];
        permutation.remove(k);
        k = v;
    }
    return cycle ~ decompose(permutation);
}
```

たとえば main として以下を試してみることができます。

```d
void main()
{
    import std.stdio : writeln;
    auto a = [0:0, 1:2, 2:1, 3:4, 4:5, 5:4]; // (0), (12), (345) に分解されるべき
    auto b = [ // アルファベット8文字の単語を64個ランダムに生成してシャッフル
        "UHAFLPIX":"BENXQVIW","OOELKPPN":"LEOGMBBK","FLDBBBCQ":"MEHMUJUN","AMFSUGTL":"TNWJGECN",
        "LCMXMEUY":"NWKQVOER","XPYUFRIK":"XSNIEIYY","JMHBROUS":"BHVJUDXW","AWSLAKKV":"KHFXIRBH",
        "TVOXWDUY":"AEVQMZTA","GUAGXXAW":"DOTNWDQL","QTADHXDF":"TMAZGDXW","APOWAFTT":"JSUJVQOO",
        "BHVJUDXW":"NBMVPCAG","LEOGMBBK":"JMHBROUS","WAHDWBOO":"WAHDWBOO","PVYDWYWX":"XPYUFRIK",
        "DYLKUSFE":"NHPCKMDB","NBMVPCAG":"CGYLBTSB","AWPAMEAS":"AMFSUGTL","XSNIEIYY":"FLDBBBCQ",
        "UMIQFVTN":"AQZVKTTN","BENXQVIW":"QXNGSYYO","QHFXZOVB":"GUAGXXAW","NHPCKMDB":"FWMYWRJI",
        "CGYLBTSB":"APOWAFTT","KSMLGGMX":"AWBXRTWP","PXRNYFWO":"QAYJXLYK","ZDWMGMIL":"OEZGQTCK",
        "TNWJGECN":"RMVMRAQH","NWKQVOER":"ADJCBSRJ","PJMUKOAT":"COSCBXFY","AQZVKTTN":"UMIQFVTN",
        "YIJOHUIO":"CHSTVDKI","DOTNWDQL":"VVXIGKJI","TMAZGDXW":"AWPAMEAS","MEHMUJUN":"PJMUKOAT",
        "RWDOJJEL":"DYLKUSFE","KHFXIRBH":"MYCFGQVR","WXYIBZZS":"RKKWBCYL","AWBXRTWP":"YIJOHUIO",
        "TWQDWVDH":"TWQDWVDH","COSCBXFY":"ZLHCYWRG","QAYJXLYK":"VFVMSRXY","OEZGQTCK":"POOXPCBK",
        "PYKZVHNF":"LCMXMEUY","RKKWBCYL":"PXRNYFWO","FWMYWRJI":"ZDWMGMIL","OYUAHWBD":"QHFXZOVB",
        "AEVQMZTA":"QTADHXDF","LDGSLJCO":"BJOMIODY","RMVMRAQH":"NDERWQIH","QXNGSYYO":"AWSLAKKV",
        "VVXIGKJI":"UHAFLPIX","MYCFGQVR":"PVYDWYWX","JSUJVQOO":"UWQTHERN","BJOMIODY":"CCBPCZNG",
        "CCBPCZNG":"PYKZVHNF","VFVMSRXY":"OYUAHWBD","POOXPCBK":"LDGSLJCO","UWQTHERN":"OOELKPPN",
        "CHSTVDKI":"RWDOJJEL","NDERWQIH":"WXYIBZZS","ZLHCYWRG":"TVOXWDUY","ADJCBSRJ":"KSMLGGMX"];
    a.decompose().writeln();
    b.decompose().writeln();

    // 問題: 置換になっていない例を与えた場合の動作を予想し実験せよ。
    auto d = [0:1, 1:2, 3:4, 4:5, 5:6, 8:6];
    d.decompose().writeln();
}
```
