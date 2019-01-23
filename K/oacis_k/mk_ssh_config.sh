#!/bin/bash
# mk_ssh_config.sh: to add K entry into ~oacis/.ssh/config 
# $1 must be specified as K username

if [ $# -ne 1 ]; then
    echo "usage: $0 K-username"
    exit 1
fi
U=$1

P=""
if [ ${SOCKS5_SERVER:-x} != "x" ]; then
    P="ProxyCommand connect -S ${SOCKS5_SERVER} %h %p"
fi

cat <<EOF >>/home/oacis/.ssh/config
StrictHostKeyChecking no
ForwardAgent yes
Host K
  User $U
  HostName k.r-ccs.riken.jp
  $P
EOF

exit 0
