#!/bin/bash
if [ "`docker network ls | grep oacis-network`x" == "x" ]; then
  docker network create oacis-network
fi
docker run --name oacis --network oacis-network --rm -p 127.0.0.1:3000:3000 -p 127.0.0.1:1222:22 -dt oacis_sim/oacis_pc

sleep 15
echo
