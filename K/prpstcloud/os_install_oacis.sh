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
eval `ssh-agent`
ssh-add id_rsa.K
echo "SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"

# copy oacis_k files to the VM server
ssh -A ubuntu@${FIP} rm -rf oacis_k
ssh -A ubuntu@${FIP} mkdir oacis_k
src=../oacis_k
scp -i id_rsa.K $src/Dockerfile $src/BUILD.sh $src/RUN.sh $src/id_rsa.K.pub \
    $src/mk_oacis_start.sh $src/mk_ssh_config.sh $src/oacis_setup.sh \
    ubuntu@${FIP}:./oacis_k/

# copy install_oacis_on_docker.sh to the VM server
scp -i id_rsa.K install_oacis_on_docker.sh ubuntu@${FIP}:./

# exec install_oacis_on_docker.sh on the VM server
ssh -n -T -A ubuntu@${FIP} ./install_oacis_on_docker.sh 2>&1 > OACIS.log &

# port 3000 forwarding
ssh -A -N -f -L 3000:localhost:3000 ubuntu@${FIP}

# kill ssh-agent if invoked
#if [ ! -z ${SSH_AGENT_PID} ]; then
#    eval `ssh-agent -k`
#fi

exit 0
