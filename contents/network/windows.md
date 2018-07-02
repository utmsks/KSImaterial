# Windowsで「ネットワークの設定と管理」相当のことをする場合

Windowsにもネットワークの設定と管理をするためのコマンドが備わっています。

Windowsコマンドを使うには、コマンドプロンプトまたはPowerShellのウィンドウを開きます。

コマンドは以下のように読み替えてください。

|Linux|Windows|
----|----
|ping|ping|
|ping lpi.jp -c 3|ping -n 3 lpi.jp|
|traceroute|tracert|
|tracepath|（ありません）|
|ip address|ipconfig|
|nmcli|（ありません）|
|nmtui|（ありません）|
|ip route / ss|netstat -r|
|nslookup|nslookup|
|ss -at|netstat -t tcp|
|ss -au|netstat -t udp|

なお、DNS設定やファイアウォール設定については、
「設定」→「ネットワークとインターネット」のパネルで確認できます。
