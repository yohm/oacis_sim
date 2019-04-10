#!/bin/bash

# unset https_proxy if set
unset https_proxy
unset HTTPS_PROXY

# source *-openrc.sh if need, and get the VM server name
if [ -z ${OS_USERNAME} ]; then
    _RC=`ls -1 *-openrc.sh | wc -l`
    if [ ${_RC} -gt 0 ]; then
	. `ls -1 *-openrc.sh | head -1`
    else
	echo "no *-openrc.sh found, exit."
	exit 1
    fi
fi
SRVNM=oacis-${OS_USERNAME}
echo "Target VM server name is ${SRVNM}"

# get floating IP address
for cnt in {1..5}; do
    FIP=`openstack --insecure server list | grep ${SRVNM} | awk '{print $9}' | head -1`
    if [ "x${FIP}" == 'x|' ]; then break; fi
    sleep 1
done
if [ -z ${FIP} ]; then
    echo "VM server ${SRVNM} is not ready."
    exit 1
fi
echo "Floating IP address of ${SRVNM} is ${FIP}"

# invoke ssh-agent locally, and add private key of K
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

# copy install_docker_on_ubuntu.sh to the VM server
scp _install_docker_on_ubuntu.sh ubuntu@${FIP}:./

# exec install_docker_on_ubuntu.sh on the VM server
ssh -n -T -A ubuntu@${FIP} 'tr -d \\r < _install_docker_on_ubuntu.sh > install_docker_on_ubuntu.sh && chmod +x install_docker_on_ubuntu.sh'
ssh -A ubuntu@${FIP} ./install_docker_on_ubuntu.sh

# kill ssh-agent if invoked
if [ ${_A} -lt 1 ]; then
    eval `ssh-agent -k`
fi

exit 0
