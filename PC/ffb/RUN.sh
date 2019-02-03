#!/bin/bash
if [ "`docker network ls | grep oacis-network`x" == "x" ]; then
  docker network create oacis-network
fi
docker run --name ffb --network oacis-network --rm -d -P oacis_sim/ffb
