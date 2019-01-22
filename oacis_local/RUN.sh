#!/bin/bash
if [ "`docker network ls | grep oacis-network`x" == "x" ]; then
  docker network create oacis-network
fi
docker run --name oacis --rm -p 127.0.0.1:3000:3000 --network oacis-network -dt oacis_sim/oacis_local

sleep 15
echo
