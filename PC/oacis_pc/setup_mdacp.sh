#!/bin/bash
ssh-keygen -R localhost
chmod go-rwx id_rsa_oacis

ssh -i id_rsa_oacis oacis@localhost -p 1222 "/home/oacis/oacis_add_host.sh mdacp"

ssh -i id_rsa_oacis oacis@localhost -p 1222 "BUNDLE_PATH=/usr/local/bundle /home/oacis/oacis/bin/oacis_ruby /home/oacis/mdacp/register_mdacp.rb"
