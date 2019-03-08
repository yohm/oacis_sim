#!/bin/bash

if [ -d ${HOME}/oacis_ffb ]; then
    exit 0
fi
if [ ! -f ${HOME}/ffb_dist.tgz ]; then
    exit 1
fi
mkdir ${HOME}/oacis_ffb
cd ${HOME}/oacis_ffb
tar xvfz ${HOME}/ffb_dist.tgz
chmod +x ${HOME}/oacis_ffb/bin/*
exit 0
