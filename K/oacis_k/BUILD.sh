docker build -t oacis_sim/oacis_k \
       --build-arg SOCKS5_SERVER="$SOCKS5_SERVER" \
       --build-arg SOCKS5_USER="$SOCKS5_USER" --build-arg SOCKS5_PASSWD="$SOCKS5_PASSWD" \
       --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" \
       --build-arg KUSER="$KUSER" \
       .
