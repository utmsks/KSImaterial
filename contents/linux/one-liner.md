# One-liner

ひとまとまりのことをさせる、1行のコマンドの並びをone-linerということがあります。
すでに扱った、パイプライン、バッククォートによるコマンド出力の置き換えなどを使うと、役に立つone-linerがいろいろ書けます。

## 簡単な制御
コマンドは実行後exit statusと呼ばれる数値をシェルに返します。普通は0が正常終了を示し、それ以外の時は何らかの意味で異常終了したことを示します。（具体的な意味はコマンドによって違うので、manで確認のこと。）

これと論理演算子&& (and)及び|| (or)を使って簡単な制御を行うことができます。&&と||は本来は論理演算子なので二つの論理値の論理積と論理和を返すのに使いますが、
- `command1 && command2` の場合、command1が正常終了（真）である場合に限って、command2が実行される
- `command1 || command2` の場合、command1が異常終了（偽）である場合に限って、command2が実行される

ことを利用して、コマンドの実行を制御することができます。

（実習）
次のコマンドを実行し、結果を解釈せよ。
```
$ grep -q zsh /etc/shells || echo ない
$ grep -q bash /etc/shells && echo ある
```

（問）
次の仕事をさせるためのone-linerを書け。

1. ディレクトリ ~/data にデータファイルがたくさんある。ディスクがいっぱいになってきたので、その中から大きなもの10個を消そうと思う。ただし、ファイル名に 'daiji' という文字列を含むものは消さない。消すファイルをサイズとともにリストせよ。（使っても使わなくてもよいヒント：サイズは `ls -s` で出てくるブロック単位でもよい）
2. 試験の成績が次のようなCSV形式で収められているファイルがある。
```
name,school,score
```
（ここで、nameとschoolは英大小文字の並び、scoreは数字。）
このファイルから、最も受験者の多かった学校（school）のレコードを抜き出して表示せよ。ただし、schoolの文字列は部分一致せず、nameのフィールドに出現しないとする。同数の場合は適当に一つを選ぶ。その他必要なら適当に仮定を追加してもよい。（使っても使わなくてもよいヒント：フィールドの切り出しにはcutが使える）
3.
One-linerを実行して、下のように（欧文の）文章を入力する（改行して^Dで終わり）と、文章を`poem.txt`に収め、行数と単語数を標準出力に書き出す。
```
$ commands...
Two roads diverted in a yellow wood,
And sorry I could not travel both
And be one traveler, long I stood
And looked down one as far as I could
To where it bent in the undergrowth:
^D
            5          37
```
(From: "The Road Not Taken" by Robert Frost)
（ヒント：標準入力をファイルと標準出力に分岐するにはteeが使える。単語数などを数えるのはwc）
