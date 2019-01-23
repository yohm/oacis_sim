#!/bin/bash

if [ -f id_rsa.K ]; then
    eval `ssh-agent`
    ssh-add id_rsa.K
fi

docker run --name oacis_K --rm -p 127.0.0.1:3000:3000 -p 127.0.0.1:2222:22 -dt oacis_sim/oacis_k

sleep 5
ssh-keygen -R localhost
#ssh-keyscan -p 2222 -H localhost >> $HOME/.ssh/known_hosts
(ssh oacis@localhost -p 2222 -A /home/oacis/oacis_start.sh) &

sleep 15
echo
