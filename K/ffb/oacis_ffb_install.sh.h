#!/bin/bash

targ_dir=${HOME}/oacis_ffb
if [ -d ${targ_dir} ]; then
    rm -rf ${targ_dir}
fi
mkdir ${targ_dir}

PAYLOAD_LINE=`awk '/^__PAYLOAD_BELOW__/ {print NR + 1; exit 0; }' $0`

tail -n+$PAYLOAD_LINE $0 | tar xvz -C ${targ_dir}
exit 0

__PAYLOAD_BELOW__
