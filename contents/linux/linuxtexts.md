# Linux 標準教科書ダウンロード

Linux のインストールが終わったら、LPI-JAPAN 作成の”Linux 標準教科書 (Ver3.0.1)”を以下の場所からダウンロードしてください。

ftp://download.ks.prv/mirror/Text/linuxtext_ver3.0.1.pdf

サポートページ http://www.lpi.or.jp/linuxtext/wiki/index.php/メインページ より「誤植などの報告」も見ておくとよい。


## 訂正
9.4.1 if文（p. 154）の書式（網掛けの部分）には誤植があります。（2019/05/29現在「誤植などの報告」に未掲載）

誤
>if 条件式 1 then ... elif 条件式 2 then ... else ... fi

正
>if [ 条件式 1 ] ; then ... elif [ 条件式 2 ] ; then ... else ... fi
