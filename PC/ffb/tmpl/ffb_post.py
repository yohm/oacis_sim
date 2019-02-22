#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""
FFBソルバー解析結果処理機能
  usage: ffb_post.py [output.txt [outpath.json]]
"""

import sys, os
import json


#----------------------------------------------------------------------
# main routine
if __name__ == '__main__':
    ffboutfn = 'les3x.log.P0001'
    ffbrjfn = '_output.json'
    if len(sys.argv) > 1:
        ffboutfn = sys.argv[1]
        if len(sys.argv) > 2:
           ffbrjfn = sys.argv[2] 

    try:
        fin = open(ffboutfn, 'r')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % ffboutfn )
        sys.exit(1)

    result = {'step':-1, 'time':-1.0, 'maxd':None, 'resp':None}
    
    for l in fin:
        if not l.startswith(' STEP'):
            continue
        try:
            toks = l.split()
            stp = int(toks[1])
            if stp <= result['step']:
                continue
            tm = float(toks[5])
            md = float(toks[7])
            rp = float(toks[9])
            result['step'] = stp
            result['time'] = tm
            result['maxd'] = md
            result['resp'] = rp
        except:
            continue
        continue # end of for(l)
    fin.close()

    try:
        fout = open(ffbrjfn, 'w')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % ffbrjfn)
        sys.exit(2)

    try:
        fout.write(json.dumps(result, indent=4, separators=(',', ': ')))
    except:
        sys.stderr.write('ERR: can not output json file: %s\n' % ffbrjfn)
        sys.exit(3)
    fout.close()

    # clean-up
    os.system("rm -f *.sh *.py *.pyc")
    os.system("rm -f les3x.mpi PARMLES3X.tmpl")
    os.system("rm -f BOUN.* MESH.*")

    sys.exit(0)


