#!/bin/bash

# invoke ssh-agen locally, and add private key of K
_A=`ssh-add -l | grep "id_rsa.K" | wc -l`
if [ ${_A} -lt 1 ]; then
    kf="id_rsa.K"
    if [ ! -f ${kf} ]; then
        read -p "specify the private key file of K: " kf
        if [ "x${kf}" == "x" -o ! -f ${kf} ]; then
            echo "invalid key file specified, exit."
            exit 1
        fi
    fi
    eval `ssh-agent`
    ssh-add ${kf}
    if [ $? != 0 ]; then
        exit 1
    fi
    echo "invoked ssh-agent: SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"
else
    echo "refer existed ssh-agent: SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"
fi

# put genesis_dist.tgz into Klogin and setup
cd ${HOME}/genesis
scp setup_genesis_K.sh genesis_dist.tgz K:./
ssh -A K ./setup_genesis_K.sh

# kill ssh-agent if invoked
if [ ${_A} -lt 1 ]; then
    eval `ssh-agent -k`
fi

exit 0

