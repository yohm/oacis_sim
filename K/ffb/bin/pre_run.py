import sys,os,subprocess,json,textwrap
import numpy as np

def create_config(outfile):
    if len(sys.argv) != 6:
        sys.stderr.write("usage: %s <density> <temperature> <length> <TotalLoop> <seed>\n" % sys.argv[0])
        raise("invalid number of arguments")
    density = float(sys.argv[1])
    temperature = float(sys.argv[2])
    length = float(sys.argv[3])
    total_loop = int(sys.argv[4])
    seed = int(sys.argv[5])
    template = textwrap.dedent('''\
               Mode=Langevin
               InitialVelocity=1.8
               TimeStep=0.005
               UnitLength={2}
               ObserveLoop=100
               TotalLoop={3}
               AimedTemperature={1}
               Density={0}
               HeatbathTau=0.1
               HeatbathGamma=0.1
               HeatbathType=Langevin
               Seed={4}
               ''')
    with open(outfile, 'w') as f:
        f.write(template.format(density,temperature,length,total_loop,seed))

try:
    create_config("langevin.cfg")
except:
    sys.exit(1)
sys.exit(0)
