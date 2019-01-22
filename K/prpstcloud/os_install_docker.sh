#!/bin/bash
if [ "x${OS_USERNAME}" == "x" ]; then
  . rccs-atd-openrc_v2.sh
fi
SRVNM=oacis_${OS_USERNAME}
echo "VM server name is ${SRVNM}"
FIP=`openstack --insecure server list 2>&1 | grep ${SRVNM} | awk '{print $9}'`
echo "Floating IP address of VM is ${FIP}"

eval `ssh-agent`
ssh-add id_rsa.K

scp -i id_rsa.K install_docker_on_ubuntu.sh ubuntu@${FIP}:./

ssh -i id_rsa.K ubuntu@${FIP} ./install_docker_on_ubuntu.sh
