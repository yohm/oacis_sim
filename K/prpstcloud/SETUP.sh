#!/bin/bash
if [ -z ${OS_USERNAME} ]; then
  . rccs-atd-openrc_v2.sh
fi

# call openstack client api
./os_create_server.sh
sleep 5 # wait for assign floating ip
./os_install_docker.sh
./os_install_oacis.sh
