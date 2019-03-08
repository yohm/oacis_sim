#!/bin/bash
. /work/system/Env_base
module load Python/2.7.14-fujitsu-sparc64

rm -f run.rst run.dcd
mpiexec -n $OACIS_MPI_PROCS -ofout-proc file_stdout ./spdyn run.inp
cat file_stdout.0 >> run.out
python -B dump_tsd.py
#python -B genesis_plot_figs.py
python -B genesis_post.py

exit $?
