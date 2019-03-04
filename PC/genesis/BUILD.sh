rm -f data.tgz
tar cvfz data_dist.tgz data

docker build -t oacis_sim/genesis --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" .
