#!/bin/bash 

# unset https_proxy if set
if [ ! -z ${https_proxy} ]; then
  unset https_proxy
fi

# source rccs-atd-openrc_v{2|3}.sh if need, and set VM server name
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
SRVNM=oacis-${OS_USERNAME}
echo "Target VM server name is ${SRVNM}"

# get public key file as id_rsa.K.pub
if [ ! -f id_rsa.K.pub ]; then
    read -p "specify the public key file of K: " kf
    if [ "x${kf}" == "x" -o ! -f ${kf} ]; then
	echo "invalid key file specified, exit."
	exit 1
    fi
    cp -f ${kf} id_rsa.K.pub
fi

# create keypair as OS_USERNAME
_K=`openstack --insecure keypair list | grep ${OS_USERNAME} | wc -l`
if [ ${_K} -lt 1 ]; then
    openstack --insecure keypair create --public-key id_rsa.K.pub ${OS_USERNAME}
fi

_S=`openstack --insecure server list | grep ${SRVNM} | wc -l`
if [ ${_S} -lt 1 ]; then
  # create VM of Ubuntu16.04_LTS, flavor: A2.small
  openstack --insecure server create --image Ubuntu16.04_LTS --flavor A2.small \
	    --network rccs-atd-internal --security-group 'allow SSH' \
	    --key-name ${OS_USERNAME} ${SRVNM}
  echo "Server ${SRVNM} created."

  # create and assign floating IP address to the VM
  FIP=`openstack --insecure floating ip create external 2>&1 | grep ' name ' | awk '{print $4}'`
  openstack --insecure server add floating ip ${SRVNM} ${FIP}
  echo "Floating IP address ${FIP} assigned."
  ssh-keygen -R ${FIP}
fi

exit 0
