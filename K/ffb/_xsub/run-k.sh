#!/bin/sh -x
#PJM --rsc-list "node=2"
#PJM --rsc-list "elapse=00:30:00"
#PJM -S
#
#PJM --stg-transfiles all
#PJM --stgin "./* ./"
#PJM --stgout "./* ./"
##PJM -o "LOG.txt"

. /work/system/Env_base

export OACIS_MPI_PROCS=2
./xrun.sh
exit $?
