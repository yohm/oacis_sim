import sys
try:
    import numpy as np
except:
    sys.stderr.write('import numpy failed.\n')
    sys.exit(1)
try:
    import GF
except:
    sys.stderr.write('import GF failed.\n')
    sys.exit(1)

if __name__ == '__main__':
    ifname = 'HISTORY.P0001'
    ofname = 'UVWP_t.dat'
    ofname2 = 'ResE_t.dat'
    if len(sys.argv) >= 2:
        if sys.argv[1] == '-h' or sys.argv[1] == '--help':
            print('usage: python dump_hdata.py [HISTORY [UVW.dat [ResE.dat]]]')
            sys.exit(0)
        ifname = sys.argv[1]
    if len(sys.argv) >= 3:
        ofname = sys.argv[2]
    if len(sys.argv) >= 4:
        ofname2 = sys.argv[3]
    h = GF.GF_FILE()
    if not h.read(ifname):
        sys.stderr.write("[Error] HISTORY file read failed: %s\n" % ifname)
        sys.exit(2)
    try:
        dat = h.dataset[0].data[1].array[:,28:]
        np.savetxt(ofname, dat, header='U V W P')
    except:
        sys.stderr.write("[Error] savetxt failed: %s\n" % ofname)
        sys.exit(3)
    try:
        dat = h.dataset[0].data[1].array[:,19:]
        np.savetxt(ofname2, dat, header='ResEnergy')
    except:
        sys.stderr.write("[Error] savetxt failed: %s\n" % ofname2)
        sys.exit(4)
    sys.exit(0)
