#!/bin/bash

# get public key file as id_rsa.K.pub
if [ ! -f id_rsa.K.pub ]; then
    read -p "specify the public key file of K: " kf
    if [ "x${kf}" == "x" -o ! -f ${kf} ]; then
	echo "invalid key file specified, exit."
	exit 1
    fi
    cp -f ${kf} id_rsa.K.pub
fi

# export KUSER if not set
if [ -z ${KUSER} ]; then
    read -p "input username of K: " KUSER
    if [ -z ${KUSER} ]; then
	exit 1
    fi
fi

# build docker image
docker build -t oacis_sim/oacis_k \
       --build-arg SOCKS5_SERVER="$SOCKS5_SERVER" \
       --build-arg SOCKS5_USER="$SOCKS5_USER" \
       --build-arg SOCKS5_PASSWD="$SOCKS5_PASSWD" \
       --build-arg http_proxy="$http_proxy" \
       --build-arg https_proxy="$https_proxy" \
       --build-arg KUSER="$KUSER" \
       .

exit $?
