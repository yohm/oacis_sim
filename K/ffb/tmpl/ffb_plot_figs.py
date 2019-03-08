import sys
try:
    import numpy as np
except:
    sys.stderr.write('import numpy failed, not installed.\n')
    sys.exit(1)
try:
    import matplotlib
except:
    sys.stderr.write('import matplotlib failed, not installed.\n')
    sys.exit(1)
matplotlib.use('Agg')
import matplotlib.pyplot as plt

def plot_UVWP(dat):
    plt.title("Velocity")
    plt.xlabel("step")
    plt.plot(dat[:,0], label="U")
    plt.plot(dat[:,1], label="V")
    plt.plot(dat[:,2], label="W")
    plt.legend()
    plt.savefig("Velocity.png")
    plt.clf()

    plt.title("Pressure")
    plt.xlabel("step")
    plt.ylabel("P")
    plt.plot(dat[:,3])
    plt.savefig("Pressure.png")
    plt.clf()

def plot_ResE(dat):
    plt.title("||Res. of Energy||")
    plt.xlabel("step")
    plt.ylabel("ResE")
    plt.plot(dat[:,0])
    plt.savefig("ResEnergy.png")
    plt.clf()


if __name__ == '__main__':
    fname = 'UVWP_t.dat'
    fname2 = 'ResE_t.dat'
    if len(sys.argv) >= 2:
        fname = sys.argv[1]
    if len(sys.argv) >= 3:
        fname2 = sys.argv[2]

    try:
        dat = np.loadtxt(fname, comments='#', delimiter=' ')
    except:
        sys.stderr.write("[Error] file read failed: %s\n" % fname)
        sys.exit(2)
    try:
        plot_UVWP(dat)
    except:
        sys.stderr.write("[Error] plot_UVWP failed.\n")
        sys.exit(3)

    try:
        dat = np.loadtxt(fname2, comments='#', delimiter=' ')
    except:
        sys.stderr.write("[Error] file read failed: %s\n" % fname2)
        sys.exit(2)
    try:
        plot_ResE(dat)
    except:
        sys.stderr.write("[Error] plot_ResE failed.\n")
        sys.exit(3)

    sys.exit(0)

