#!/bin/bash

# invoke ssh-agen locally, add private key of K
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

# and exec setup_oacis_os.sh
exec ./setup_oacis_os.sh