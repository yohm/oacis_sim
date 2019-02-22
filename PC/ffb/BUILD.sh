#!/bin/bash
if [ ! -f data_tmpl.tgz ]; then
  tar cvfz data_tmpl.tgz data tmpl
fi
docker build -t oacis_sim/ffb --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" .
