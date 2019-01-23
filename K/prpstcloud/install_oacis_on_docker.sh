#!/bin/bash

export KUSER=`hostname | cut -c 7-`
echo "KUSER=${KUSER}"

docker pull oacis/oacis

echo "StrictHostKeyChecking no" >> ${HOME}/.ssh/config
echo "ForwardAgent yes" >> ${HOME}/.ssh/config

cd ${HOME}/oacis_k
./BUILD.sh
./RUN.sh
