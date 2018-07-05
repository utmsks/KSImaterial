# 実習環境で「ネットワークの設定と管理」を試す際の注意
「Linux 標準教科書（Ver.3.0.1）」の
第10章「ネットワークの設定と管理」のコマンド例を
204号室の計算数学実習用PCを使って試す際の注意を書いておきます。

テキスト通りにできない・ならない理由には

* Linuxディストリビューションの違いによるもの
* 実習用ネットワークの構成によるもの

があります。

テキストにはUbuntuで標準インストールされていないコマンドが使われていることがありますが、ほとんどは、そのコマンド名を入力するとインストールのためのaptコマンド例が表示されるので、使いたい場合はそれに従ってください。

プロンプトが`# `になっているコマンド例はroot（管理者）での実行を表していますが、Ubuntuではrootでの作業を推奨されていないので`sudo`コマンドを使ってください。

## p. 171 pingコマンド
p. 171の一つ目のpingコマンドの実行の際、LAN上のホストのアドレスとしては`192.168.1.31`を指定してください。

なお、pingコマンドは実習室ネットワーク内では使えますが、外のネットワーク上のアドレスに対しては使えません。
このため、p. 171の二つ目のpingコマンドの実行例は動作しません。

## p. 176 traceroute & tracepath
実習室外のネットワーク上のアドレスに対してtraceroute, tracepathとも使えません。
また、Ubuntu
ではtracerouteコマンドは標準インストールされていません。

## p. 177 ifconfig
ifconfigは標準インストールされていません。

## p. 178 IPアドレスの設定ファイル
10.4.3「IPアドレスの設定ファイル」及び
10.4.4「インターフェイスの設定」はUbuntuには対応していないので、省略してください。

Ubuntu 18.04ではネットワークインターフェイスをNetworkManagerとsystemd-networkdによって管理しています。検索して調べる際には、必ずUbuntuのバージョンを指定してください。
***実習ではネットワークインターフェイス設定の変更を行わないでください。***

## p. 182 ルーティングの変更
Ubuntuでも実行例の通り行えますが、
***実習ではルーティングの変更を行わないでください。***

## p. 184 resolv.conf
Ubuntu 18.04ではこのファイルは参照用にのみ残されています。
systemd-resolvedが実際の名前解決の管理を行っています。

## p. 188 firewalld, iptables
Ubuntuにはfirewalldは入っていないので、
10.9.1「ファイウォール（firewalld）の設定」及び
10.9.2「iptablesへの切り替え」はUbuntuに対応していないので、省略してください。

Ubuntuにはfirewalldは入っていません。iptablesは入っていますが、操作が複雑なので必要ならufwまたはそのGUI版gufwを調べてみてください。

## p. 194 CentOS7/CentOS6
10.10「CentOS 7とCentOS 6の比較」は無関係なので省略してください。