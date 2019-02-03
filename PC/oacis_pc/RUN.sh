#!/bin/bash
if [ "`docker network ls | grep oacis-network`x" == "x" ]; then
  docker network create oacis-network
fi

HOSTPREFX="127.0.0.1:"
if [[ ! -z ${DOCKER_MACHINE_NAME} ]]; then
	HOSTPREFX=""
fi
docker run --name oacis --network oacis-network --rm -p ${HOSTPREFX}3000:3000 -p ${HOSTPREFX}2222:22 -dt oacis_sim/oacis_pc

sleep 15
echo
