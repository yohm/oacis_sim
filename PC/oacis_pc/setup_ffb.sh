#!/bin/bash

TARGHOST=localhost
if [[ ! -z ${DOCKER_MACHINE_NAME} ]]; then
	TARGHOST=`docker-machine ip`
fi

if [ ! -d "${HOME}/.ssh" ]; then
	mkdir "${HOME}/.ssh"
	chmod 700 "${HOME}/.ssh"
fi
echo 'StrictHostKeyChecking no' >> "${HOME}/.ssh/config"
chmod go-rwx "${HOME}/.ssh/config"
ssh-keygen -R ${TARGHOST}:2222

chmod go-rwx id_rsa_oacis

ssh -i id_rsa_oacis oacis@${TARGHOST} -p 2222 "/home/oacis/oacis_add_host.sh ffb"

ssh -i id_rsa_oacis oacis@${TARGHOST} -p 2222 "BUNDLE_PATH=/usr/local/bundle /home/oacis/oacis/bin/oacis_ruby /home/oacis/ffb/register_ffb.rb"

exit 0
