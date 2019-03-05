#!/bin/bash
set -e
mpiexec -n $OACIS_MPI_PROCS ./les3x.mpi | tee les3x.log.P0001
python dump_hdata.py
python ffb_plot_figs.py
python ffb_post.py

