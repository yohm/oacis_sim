import sys
try:
    import numpy as np
except:
    sys.stderr.write('import numpy failed.\n')
    sys.exit(1)

if __name__ == '__main__':
    ifname = 'run.out'
    ofname = 'energy.dat'
    ofname2 = 'temperature.dat'
    ofname3 = 'volume.dat'
    if len(sys.argv) >= 2:
        if sys.argv[1] == '-h' or sys.argv[1] == '--help':
            print('usage: python dump_tsd.py [run.out [ene.dat temp.dat vol.dat]]')
            sys.exit(0)
        ifname = sys.argv[1]
    if len(sys.argv) >= 3:
        ofname = sys.argv[2]
    if len(sys.argv) >= 4:
        ofname2 = sys.argv[3]
    if len(sys.argv) >= 5:
        ofname3 = sys.argv[4]

    try:
        fin = open(ifname, 'r')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % ifname)
        sys.exit(1)

    dset = {'step':[], 't_ene':[], 'p_ene':[], 'k_ene':[], 'temp':[], 'vol':[]}
    for l in fin:
        if not l.startswith('INFO:'):
            continue
        try:
            toks = l.split()
            stp = int(toks[1])
            te = float(toks[3])
            pe = float(toks[4])
            ke = float(toks[5])
            t = float(toks[15])
            v = float(toks[16])
            dset['step'].append(stp)
            dset['t_ene'].append(te)
            dset['p_ene'].append(pe)
            dset['k_ene'].append(ke)
            dset['temp'].append(t)
            dset['vol'].append(v)
        except:
            continue
        continue # end of for(l)
    fin.close()

    try:
        dset['step'] = np.array(dset['step']).reshape((len(dset['step']),1))
        dset['t_ene'] = np.array(dset['t_ene']).reshape((len(dset['t_ene']),1))
        dset['p_ene'] = np.array(dset['p_ene']).reshape((len(dset['p_ene']),1))
        dset['k_ene'] = np.array(dset['k_ene']).reshape((len(dset['k_ene']),1))
        dset['temp'] = np.array(dset['temp']).reshape((len(dset['temp']),1))
        dset['vol'] = np.array(dset['vol']).reshape((len(dset['vol']),1))
    except:
        sys.stderr.write('ERR: can not process data\n')
        sys.exit(1)
        
    try:
        dat = np.concatenate((dset['step'], dset['t_ene'], dset['p_ene'], dset['k_ene']), 1)
        np.savetxt(ofname, dat, header='STEP  TOTAL_ENE  POTENTIAL_ENE  KINETIC_ENE')
    except:
        sys.stderr.write("[Error] savetxt failed: %s\n" % ofname)
        sys.exit(2)
    try:
        dat2 = np.concatenate((dset['step'], dset['temp']), 1)
        np.savetxt(ofname2, dat2, header='TEMPERATURE')
    except:
        sys.stderr.write("[Error] savetxt failed: %s\n" % ofname2)
        sys.exit(3)
    try:
        dat3 = np.concatenate((dset['step'], dset['vol']), 1)
        np.savetxt(ofname3, dat3, header='VOLUME')
    except:
        sys.stderr.write("[Error] savetxt failed: %s\n" % ofname3)
        sys.exit(4)
    sys.exit(0)
