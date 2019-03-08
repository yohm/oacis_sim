#!/bin/bash

if [ -d ${HOME}/oacis_mdacp ]; then
    exit 0
fi
if [ ! -f ${HOME}/mdacp_dist.tgz ]; then
    exit 1
fi
mkdir ${HOME}/oacis_mdacp
cd ${HOME}/oacis_mdacp
tar xvfz ${HOME}/mdacp_dist.tgz
chmod +x *
exit 0
