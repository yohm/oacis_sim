#!/bin/bash

export KUSER=`hostname | cut -c 7-12`
echo "KUSER=${KUSER}"

cd ${HOME}/oacis_k
./RUN.sh
