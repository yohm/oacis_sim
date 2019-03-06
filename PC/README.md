# OACIS demo environment with simulators / PC

1台のPC上で、OACISとシミュレータを動作させるデモ環境です。

OACISも各シミュレータも、それぞれPC上のDockerコンテナ上で稼働します。

## 事前準備

デモを実行するPCには、Dockerがインストールされている必要があります。

See [Docker Desktop](https://www.docker.com/get-started) for macOS, Windows10 Pro or above,
    [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/) for Windows10 Home, Windows8.1 or old

## 利用方法

このディレクトリ(PC/)配下の`util/start_oacis_dockers.sh`を実行すると、
必要なDockerイメージが作成され、コンテナが起動します。

```
$ util/start_oacis_dockers.sh -h
start_oacis_dockers.sh: start oacis docker container (from oacis_sim/oacis_pc)
usage: start_oacis_dockers.sh [-f|--ffb] [-g|--genesis] [-m|--mdacp]
  -f, --ffb     start ffb docker container (from oacis_sim/ffb) simultaneously
  -g, --genesis start genesis docker container (from oacis_sim/genesis) simultaneously
  -m, --mdacp   start mdacp docker container (from oacis_sim/mdacp) simultaneously
```

オプションなしでこのコマンドを実行すると、OACISのDockerコンテナが起動します。
その後、Webブラウザで`localhost:3000/`にアクセスするとOACISのポータル画面が表示されます。

ffbオプション(-fまたは--ffb)とgenesisオプション(-mまたは--genesis)、
mdacpオプション(-mまたは--mdacp)が指定されると、
各シミュレータの実行環境がインストールされたDockerコンテナも同時に起動します。
OACISのDockerコンテナにはHost, Simulatorの登録が行われます。

各オプションは同時に指定することができます。
例えばffbとmdacp(およびOACIS)のDockerコンテナを同時に起動する場合は、
以下のようにstart_oacis_dockers.shを実行します。
```
start_oacis_dockers.sh -f -m
```

尚、起動したコンテナの停止、イメージの削除を行うためのユーティリティが
`util/stop_oacis_dockers.sh`にあります。

```
$ util/stop_oacis_dockers.sh -h
stop_oacis_dockers.sh: stop all docker containers (from oacis_sim/* image)
usage: stop_oacis_dockers.sh [-d [-i]]
  -d  delete oacis_sim/* docker image(s) simultaneously
  -i  request confirmation before delete each docker image
```

オプションなしでこのコマンドを実行すると、起動したDockerコンテナ
(ベースのDockerイメージが"oacis_sim/*"のもの)を全て停止します。
停止されたDockerコンテナは、自動的に削除されます(しかし、Dockerイメージは残っています)。

"-d"オプションをつけると、ベースとなったDockerイメージの削除も行います。
この時"-i"オプションを付けると、各イメージごとに削除するかどうかを尋ねます。

## License

- [oacis_sim](https://github.com/Fujitsu-Nagano-CES/oacis_sim) is a part of [OACIS](https://github.com/crest-cassia/oacis).
- OACIS and oacis_docker are published under the term of the MIT License (MIT).
- Copyright (c) 2018-2019 Fujitsu and R-CCS, RIKEN

