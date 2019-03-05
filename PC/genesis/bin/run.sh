#!/bin/bash
set -e
rm -f run.rst run.dcd
mpiexec -n $OACIS_MPI_PROCS ./spdyn run.inp | tee run.out
python dump_tsd.py
python genesis_plot_figs.py
python genesis_post.py
