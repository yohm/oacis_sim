#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""
GENESISソルバー解析結果処理機能
  usage: genesis_post.py [output.txt [outpath.json]]
"""

import sys, os
import json


#----------------------------------------------------------------------
# main routine
if __name__ == '__main__':
    outfn = 'run.out'
    rjfn = '_output.json'
    if len(sys.argv) > 1:
        outfn = sys.argv[1]
        if len(sys.argv) > 2:
           rjfn = sys.argv[2] 

    try:
        fin = open(outfn, 'r')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % outfn )
        sys.exit(1)

    result = {'step':-1, 'time':-1.0, 'total_ene':None, 'potential_ene':None,
              'kinetic_ene':None, 'temperature':None, 'volume':None}
    
    for l in fin:
        if not l.startswith('INFO:'):
            continue
        try:
            toks = l.split()
            stp = int(toks[1])
            if stp <= result['step']:
                continue
            tm = float(toks[2])
            te = float(toks[3])
            pe = float(toks[4])
            ke = float(toks[5])
            t = float(toks[15])
            v = float(toks[16])
            result['step'] = stp
            result['time'] = tm
            result['total_ene'] = te
            result['potential_ene'] = pe
            result['kinetic_ene'] = ke
            result['temperature'] = t
            result['volume'] = v
        except:
            continue
        continue # end of for(l)
    fin.close()

    try:
        fout = open(rjfn, 'w')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % rjfn)
        sys.exit(2)

    try:
        fout.write(json.dumps(result, indent=4, separators=(',', ': ')))
    except:
        sys.stderr.write('ERR: can not output json file: %s\n' % rjfn)
        sys.exit(3)
    fout.close()

    # clean-up
    os.system("rm -f *.sh *.py *.pyc")
    os.system("rm -f spdyn run.inp.impl")
    os.system("rm -rf 1_setup 4_equilibration")

    sys.exit(0)

