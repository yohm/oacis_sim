#!/bin/bash

# source *-openrc.sh if need, and get the VM server name
if [ -z ${OS_USERNAME} ]; then
    _RC=`ls -1 *-openrc.sh | wc -l`
    if [ ${_RC} -gt 0 ]; then
	. `ls -1 *-openrc.sh | head -1`
    else
	echo "no *-openrc.sh found."
        read -p "specify the OpenStack RC file of K prpst cloud: " osrc
        if [ "x${osrc}" == "x" -o ! -f ${osrc} ]; then
	    exit 1
        fi
        . ${osrc}
    fi
fi

# call openstack client api
./os_create_server.sh
sleep 5 # wait for assign floating ip
./os_install_docker.sh
./os_install_oacis.sh
