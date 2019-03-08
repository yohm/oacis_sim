#!/bin/bash

if [ -d ${HOME}/oacis_genesis ]; then
    exit 0
fi
if [ ! -f ${HOME}/genesis_dist.tgz ]; then
    exit 1
fi
mkdir ${HOME}/oacis_genesis
cd ${HOME}/oacis_genesis
tar xvfz ${HOME}/genesis_dist.tgz
chmod +x ${HOME}/oacis_genesis/bin/*
exit 0
