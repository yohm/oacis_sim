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

# get floating IP address
FIP=`openstack --insecure server list | grep ${SRVNM} | awk '{print $9}' | head -1`

# kill port forwarding ssh (may not work on Windows...)
if [ ! -z ${FIP} ]; then
    _P=`ps ax | grep ssh | grep ${FIP} | awk '{print $1}'`
    if [[ ! -z ${_P} ]]; then
	kill ${_P}
    fi
fi

# delete OpenStack resources
openstack --insecure server delete ${SRVNM}
if [ ! -z ${FIP} ]; then
    openstack --insecure floating ip delete ${FIP}
fi
openstack --insecure keypair delete ${OS_USERNAME}

exit $?
