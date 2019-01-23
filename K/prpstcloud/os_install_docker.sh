#!/bin/bash

# unset https_proxy if set
if [ ! -z ${https_proxy} ]; then
    unset https_proxy
fi

# source rccs-atd-openrc_v2.sh if need, and get the VM server name
if [ -z ${OS_USERNAME} ]; then
    . rccs-atd-openrc_v2.sh
fi
SRVNM=oacis_${OS_USERNAME}
echo "Target VM server name is ${SRVNM}"

# get floating IP address
FIP=`openstack --insecure server list | grep ${SRVNM} | awk '{print $9}' | head -1`
if [ -z ${FIP} ]; then
    echo "VM server ${SRVNM} is not exists."
    exit 1
fi
echo "Floating IP address of ${SRVNM} is ${FIP}"

# invoke ssh-agen locally, and add private key of K
_A=`ssh-add -l | grep "id_rsa.K" | wc -l`
if [ ${_A} -lt 1 ]; then
    eval `ssh-agent`
    ssh-add id_rsa.K
    echo "invoked ssh-agent: SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"
fi

# copy install_docker_on_ubuntu.sh to the VM server
scp -i id_rsa.K install_docker_on_ubuntu.sh ubuntu@${FIP}:./

# exec install_docker_on_ubuntu.sh on the VM server
ssh -A ubuntu@${FIP} ./install_docker_on_ubuntu.sh

# kill ssh-agent if invoked
if [ ${_A} -lt 1 ]; then
    eval `ssh-agent -k`
fi

exit 0
