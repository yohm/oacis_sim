#!/bin/sh -x
#PJM --rsc-list "node=8"
#PJM --rsc-list "elapse=00:30:00"
#PJM -S
#
#PJM --stg-transfiles all
#PJM --stgin-dir "./1_setup ./1_setup"
#PJM --stgin-dir "./4_equilibration ./4_equilibration"
#PJM --stgin "./* ./"
#PJM --stgout "./* ./"

. /work/system/Env_base

export OACIS_MPI_PROCS=8
./xrun.sh
exit $?
