. /work/system/Env_base
module load Python/2.7.14-fujitsu-sparc64
module load MPIGCC/6.3.0-gnu-sparc64

if [ $# -ne 5 ]; then
  echo "invalid arguments" 1>&2
  exit 1
fi
python pre_run.py $1 $2 $3 $4 $5
mpiexec -ofout timeseries.dat ./mdacp langevin.cfg
python post_run.py

exit 0
