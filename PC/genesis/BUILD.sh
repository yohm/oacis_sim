#!/bin/bash
if [ ! -f data_dist.tgz ]; then
  tar cvfz data_dist.tgz data
fi
docker build -t oacis_sim/genesis --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" .
