import sys,os,subprocess,json,textwrap
import numpy as np

def print_json(dat):
    avg_t = np.average(dat[-200:,1])
    avg_p = np.average(dat[-200:,2])
    avg_e = np.average(dat[-200:,3])
    j = {"temperature": avg_t, "pressure": avg_p, "energy": avg_e}
    f = open("_output.json", 'w')
    json.dump(j, f)
    f.close()

try:
    dat = np.loadtxt("timeseries.dat", comments='#', delimiter=' ')
    print_json(dat)
except Exception, e:
    sys.stderr.write("load timeseries.dat or pront_json failed\n")
    sys.stderr.write(str(e) + "\n")
    sys.exit(1)
sys.exit(0)
