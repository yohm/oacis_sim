#!/bin/bash

rm -i run.rst run.dcd

# set the number of OpenMP threads
export OMP_NUM_THREADS=1
# perform equilibration with SPDYN by using 8 MPI processes
mpirun -np 8 spdyn run.inp | tee run.out

