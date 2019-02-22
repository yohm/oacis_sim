#!/bin/bash
if [ ! -f ffb_dist.tgz ]; then
  tar cvfz ffb_dist.tgz bin tmpl data
fi
docker build -t oacis_sim/ffb --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" .
