#!/bin/bash 
if [ "x${OS_USERNAME}" == "x" ]; then
  . rccs-atd-openrc_v2.sh
fi
SRVNM=oacis_${OS_USERNAME}
echo "VM server name is ${SRVNM}"

# create keypair as OS_USERNAME
#if [ ! -f ${OS_USERNAME}.pem ]; then
#  openstack --insecure keypair create ${OS_USERNAME} > ${OS_USERNAME}.pem
#  chmod 600 ${OS_USERNAME}.pem
#fi
openstack --insecure keypair create --public-key id_rsa.K.pub ${OS_USERNAME}

_S=`openstack --insecure server list | grep ${SRVNM}`
if [ "x$S" == "x" ]; then
  # create VM of Ubuntu16.04_LTS, flavor: A2.small
  openstack --insecure server create --image Ubuntu16.04_LTS --flavor A2.small \
   --network rccs-atd-internal --security-group 'allow SSH' --key-name ${OS_USERNAME} ${SRVNM}

  # create and assign floating IP address to the VM
  FIP=`openstack --insecure  floating ip create external 2>&1 | grep ' name ' | awk '{print $4}'`
  openstack --insecure server add floating ip ${SRVNM} ${FIP}
  echo "Floating IP address ${FIP} assigned."
else
  FIP=`openstack --insecure server list 2>&1 | grep ${SRVNM} | awk '{print $9}'`
fi

