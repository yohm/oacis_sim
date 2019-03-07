. /work/system/Env_base

if [ $# -ne 5 ]; then
  echo "invalid arguments" 1>&2
  exit 1
fi
python pre_run.py $1 $2 $3 $4 $5
mpiexec -ofout timeseries.dat ./les3x.mpi
python post_run.py

exit 0
