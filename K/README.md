# 京コンピュータ向けOACIS環境

京コンピュータを計算ホストとして使用するOACISデモ環境です。

シミュレータは京コンピュータで実行します。

OACISの動作環境には、以下の２種類があります。

## oacis_k

ユーザPCにインストールされたDocker上でOACISを動作させます。

ユーザPCにはDockerがインストールされている必要があります。
また、ユーザPCから京のログインノードにアクセス出来る環境が必要です。

## prpstcloud

京のプリポストクラウド環境にDockerをインストールし、その上でコンテナ(oacis_k)を
動作させます。

ユーザPCから京のログインノードにアクセス出来る環境に加え、
京のプリポストクラウド環境にアクセスできる環境が必要です。
ただし、ユーザPCにはDockerのインストールは必要ありません。

See [prpstcloud/README.md](prpstcloud/README.md)

## License

- [oacis_sim](https://github.com/Fujitsu-Nagano-CES/oacis_sim) is a part of [OACIS](https://github.com/crest-cassia/oacis).
- OACIS and oacis_docker are published under the term of the MIT License (MIT).
- Copyright (c) 2018-2019 Fujitsu and R-CCS, RIKEN

