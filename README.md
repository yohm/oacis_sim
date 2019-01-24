# OACIS demo environment with simulators

OACISのシミュレータ連携用デモ環境です。

連携するシミュレータは、FrontFlow/Blue(FFB), GENESIS, MDACPです。

See [FFB](http://www.ciss.iis.u-tokyo.ac.jp/software/#software),
    [GENESIS](https://www.r-ccs.riken.jp/software_center/jp/software/genesis/),
    [MDACP](https://ma.issp.u-tokyo.ac.jp/en/app/353)
    and [OACIS](https://github.com/crest-cassia/oacis)

## K

京コンピュータ用のデモ環境です。

OACISは、京のプリポストクラウド上の仮装マシンにDockerをインストールし、
そこで動作するoacis_dockerコンテナ上で稼働します。

シミュレータは京コンピュータで実行します。

## PC

1台のPC上で、OACISとシミュレータを動作させるデモ環境です。

OACISも各シミュレータも、それぞれPC上のDockerコンテナ上で稼働します。


## License

- [oacis_sim](https://github.com/Fujitsu-Nagano-CES/oacis_sim) is a part of [OACIS](https://github.com/crest-cassia/oacis).
- OACIS and oacis_docker are published under the term of the MIT License (MIT).
- Copyright (c) 2018-2019 Fujitsu and R-CCS, RIKEN

