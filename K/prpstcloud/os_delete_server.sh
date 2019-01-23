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

# get floating IP address
FIP=`openstack --insecure server list | grep ${SRVNM} | awk '{print $9}' | head -1`

# kill port forwarding ssh
if [ ! -z ${FIP} ]; then
    _P=`ps ax | grep ssh | grep ${FIP} | awk '{print $1}'`
    if [ ! -z ${_P} ]; then
	kill ${_P}
    fi
fi

# delete OpenStack resources
openstack --insecure server delete ${SRVNM}
if [ ! -z ${FIP} ]; then
    openstack --insecure floating ip delete ${FIP}
fi
openstack --insecure keypair delete ${OS_USERNAME}

