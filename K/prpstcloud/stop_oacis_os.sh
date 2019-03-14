#!/bin/bash

# oacis_sim/K/prpstcloud base directory
_BD="`dirname $0`"
cd ${_BD}

# invoke os_delete_server.sh
./os_delete_server.sh

exit $?

