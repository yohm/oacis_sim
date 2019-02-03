#!/bin/bash

HOSTPREFX="127.0.0.1:"
TARGHOST="localhost"
if [[ ! -z ${DOCKER_MACHINE_NAME} ]]; then
	HOSTPREFX=""
	TARGHOST=`docker-machine ip`
fi

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
    echo "invoked ssh-agent: SSH_AUTH_SOCK=${SSH_AUTH_SOCK=}"
fi

# create/run oacis_K docker container
docker run --name oacis_K --rm -p ${HOSTPREFX}3000:3000 -p ${HOSTPREFX}2222:22 \
       -dt oacis_sim/oacis_k
sleep 5

# remove ${TARGHOST} entry from knownhosts
ssh-keygen -R ${TARGHOST}
#ssh-keyscan -p 2222 -H ${TARGHOST} >> $HOME/.ssh/known_hosts

# start oacis on oacis_K via ssh with ssh-agent
echo "run oacis_start.sh on ${TARGHOST}"
(ssh oacis@${TARGHOST} -p 2222 -A /home/oacis/oacis_start.sh) &
sleep 15
echo

exit 0
