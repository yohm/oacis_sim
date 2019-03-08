#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""
GENESISソルバー入力ファイル生成機能
  usage: genesis_prep.py [inputfile.json]
"""

import sys, os
import json
try:
    from conv_tmpl import *
except Exception as e:
    sys.stderr.write('ERR: %s\n' % str(e))
    sys.exit(2)


#----------------------------------------------------------------------
# main routine
if __name__ == '__main__':
    ijfn = '_input.json'
    if len(sys.argv) > 1:
        ijfn = sys.argv[1]

    pd = {}
    try:
        with open(ijfn) as ijf:
            pd = json.load(ijf)
    except:
        pass
    if not ConvTmpl('run.inp.tmpl', 'run.inp', pd):
        sys.exit(1)

    sys.exit(0)


