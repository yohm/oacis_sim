#!/bin/bash

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.ORG
cat /etc/ssh/sshd_config.ORG | sed -e 's/^TCPKeepAlive yes/TCPKeepAlive no/' > /tmp/sshd_config.X
sudo cp /tmp/sshd_config.X /etc/ssh/sshd_config
sshdpid=`ps ax | grep 'sshd -D' | grep -v grep | head -1 | awk '{print $1}'`
if [ ! -z ${sshdpid} ]; then
    sudo kill -HUP ${sshdpid}
fi

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo gpasswd -a $(whoami) docker
sudo chgrp docker /var/run/docker.sock
sudo service docker restart
