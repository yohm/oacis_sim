#!/bin/bash

# unset https_proxy if set
if [ ! -z ${https_proxy} ]; then
  unset https_proxy
fi

# source rccs-atd-openrc_v{2|3}.sh if need, and get the VM server name
if [ -z ${OS_USERNAME} ]; then
    if [ -f rccs-atd-openrc_v2.sh ]; then
	. rccs-atd-openrc_v2.sh
    elif [ -f rccs-atd-openrc_v3.sh ]; then
	. rccs-atd-openrc_v3.sh
    else
	echo "both rccs-atd-openrc_v2.sh and rccs-atd-openrc_v3.sh does not exist, exit."
	exit 1
    fi
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

# get public key file as id_rsa.K.pub
if [ ! -f id_rsa.K.pub ]; then
    read -p "specify the public key file of K: " kf
    if [ "x${kf}" == "x" -o ! -f ${kf} ]; then
	echo "invalid key file specified, exit."
	exit 1
    fi
    cp -f ${kf} id_rsa.K.pub
fi

# copy oacis_k files to the VM server
ssh -A ubuntu@${FIP} rm -rf oacis_k
ssh -A ubuntu@${FIP} mkdir oacis_k
src=../oacis_k
scp $src/Dockerfile $src/BUILD.sh $src/RUN.sh \
    $src/mk_oacis_start.sh $src/mk_ssh_config.sh $src/oacis_setup.sh \
    id_rsa.K.pub ubuntu@${FIP}:./oacis_k/

# copy install_oacis_on_docker.sh to the VM server
scp *_oacis_on_docker.sh ubuntu@${FIP}:./

# start port forwarding
ssh -A -N -f -L 3000:localhost:3000 ubuntu@${FIP}

# exec install_oacis_on_docker.sh on the VM server
ssh -n -T -A ubuntu@${FIP} ./install_oacis_on_docker.sh

# exec start_oacis_on_docker.sh on the VM server
ssh -n -T -A ubuntu@${FIP} ./start_oacis_on_docker.sh 2>&1 > start_oacis.log &
sleep 15

# kill ssh-agent if invoked
#if [ ${_A} -lt 1 ]; then
#    eval `ssh-agent -k`
#fi

exit 0
