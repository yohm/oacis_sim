. /work/system/Env_base
module load Python/2.7.14-fujitsu-sparc64

mpiexec -n $OACIS_MPI_PROCS -ofout-proc file_stdout ./les3x.mpi
cat file_stdout.0 >> les3x.log.P0001

python -B dump_hdata.py
#python -B ffb_plot_figs.py
python -B ffb_post.py
exit $?
