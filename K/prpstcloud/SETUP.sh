#!/bin/bash
if [ -z ${OS_USERNAME} ]; then
  . rccs-atd-openrc_v2.sh
fi

./os_create_server.sh
sleep 5
./os_install_docker.sh
