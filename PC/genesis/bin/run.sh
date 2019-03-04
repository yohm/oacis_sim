#!/bin/bash

export OMP_NUM_THREADS=1

rm -f run.rst run.dcd
mpiexec -n 8 spdyn run.inp | tee run.out

