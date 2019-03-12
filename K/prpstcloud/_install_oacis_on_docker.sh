#!/bin/bash

export KUSER=`hostname | cut -c 7-12`
echo "KUSER=${KUSER}"

docker pull oacis/oacis

echo "StrictHostKeyChecking no" >> ${HOME}/.ssh/config
echo "ForwardAgent yes" >> ${HOME}/.ssh/config
echo "Host K" >> ${HOME}/.ssh/config
echo "   User ${KUSER}" >> ${HOME}/.ssh/config
echo "   HostName k.r-ccs.riken.jp" >> ${HOME}/.ssh/config
chmod go-rwx ${HOME}/.ssh/config

#sudo echo "127.0.1.1 `hostname`" >> /etc/hosts

cd ${HOME}/oacis_k
./BUILD.sh
