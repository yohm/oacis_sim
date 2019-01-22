#!/bin/bash
. rccs-atd-openrc_v2.sh

./os_create_server.sh
sleep 5
./os_install_docker.sh
