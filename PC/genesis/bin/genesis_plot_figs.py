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

def plot_energy(dat):
    plt.title("Energy")
    plt.xlabel("step")
    plt.plot(dat[:,0], dat[:,1], label="Total energy")
    plt.plot(dat[:,0], dat[:,2], label="Potential energy")
    plt.plot(dat[:,0], dat[:,3], label="Kinetic energy")
    plt.legend()
    plt.savefig("Energy.png")
    plt.clf()

def plot_temperature(dat):
    plt.title("Temperature")
    plt.xlabel("step")
    plt.plot(dat[:,0], dat[:,1], label="Temperature")
    plt.savefig("Temperature.png")
    plt.clf()

def plot_volume(dat):
    plt.title("Volume")
    plt.xlabel("step")
    plt.plot(dat[:,0], dat[:,1], label="Volume")
    plt.savefig("Volume.png")
    plt.clf()


if __name__ == '__main__':
    fname = 'energy.dat'
    fname2 = 'temperature.dat'
    fname3 = 'volume.dat'
    if len(sys.argv) >= 2:
        fname = sys.argv[1]
    if len(sys.argv) >= 3:
        fname2 = sys.argv[2]
    if len(sys.argv) >= 4:
        fname3 = sys.argv[3]

    try:
        dat = np.loadtxt(fname, comments='#', delimiter=' ')
    except:
        sys.stderr.write("[Error] file read failed: %s\n" % fname)
        sys.exit(2)
    try:
        plot_energy(dat)
    except:
        sys.stderr.write("[Error] plot_energy failed.\n")
        sys.exit(3)

    try:
        dat = np.loadtxt(fname2, comments='#', delimiter=' ')
    except:
        sys.stderr.write("[Error] file read failed: %s\n" % fname2)
        sys.exit(2)
    try:
        plot_temperature(dat)
    except:
        sys.stderr.write("[Error] plot_temperature failed.\n")
        sys.exit(3)

    try:
        dat = np.loadtxt(fname3, comments='#', delimiter=' ')
    except:
        sys.stderr.write("[Error] file read failed: %s\n" % fname3)
        sys.exit(2)
    try:
        plot_volume(dat)
    except:
        sys.stderr.write("[Error] plot_volume failed.\n")
        sys.exit(3)

    sys.exit(0)

