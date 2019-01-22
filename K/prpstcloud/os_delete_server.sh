#!/bin/bash 
if [ "x${OS_USERNAME}" == "x" ]; then
  . rccs-atd-openrc_v2.sh
fi
SRVNM=oacis_${OS_USERNAME}
FIP=`openstack --insecure server list 2>&1 | grep ${SRVNM} | awk '{print $9}'`

openstack --insecure server delete ${SRVNM}
openstack --insecure floating ip delete ${FIP}
openstack --insecure keypair delete ${OS_USERNAME}

exit 0
