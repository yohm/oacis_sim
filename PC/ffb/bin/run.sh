#!/bin/bash
set -e
mpiexec -n $OACIS_MPI_PROCS ./les3x.mpi | tee les3x.log.P0001
./hscat.pl `echo HISTORY.P*` HISTORY

