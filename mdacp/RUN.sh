#!/bin/bash
if [ "`docker network ls | grep oacis-network`x" == "x" ]; then
  docker network create oacis-network
fi
docker run --name mdacp --network oacis-network --rm -d -P -p 2222:22 oacis_sim/mdacp
