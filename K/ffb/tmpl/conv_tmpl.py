#! /usr/bin/env python
# -*- coding: utf-8 -*-
"""
FFB用テンプレート変換機能
"""

import sys, os
import re
import ast

#----------------------------------------------------------------------
# utils
def GetSurrogateFunc(expression='VAL'):
    """
    式をPython関数にコンパイルする
    　式は
    [in]expression  VALを変数としたPythonの式の文字列
    戻り値 -> サロゲート関数
    """
    # ベースになる関数のソース
    defun = "def surrogate(VAL): return True\n";

    # ASTにパース
    xast = ast.parse(defun, mode='single')

    # AST中のベース関数の戻り値(True)を、expressionのASTノードに置き換え
    xast.body[0].body[0].value = \
        ast.parse(expression, mode='single').body[0].value
    # Pythonコードにコンパイル
    com = compile(xast, '<string>', 'single')

    # 関数定義をサンドボックス内で実行
    locals={}
    eval(com, {}, locals)

    # 定義された関数を返す
    return locals['surrogate']


def DecompPattern(s):
    """
    パラメータ記述形式の分解
      記述形式 ::= %パラメータ名[!デフォルト値][：式(VAL)]%

    [in] s  パラメータ記述文字列
    戻り値 -> (パラメータ名, デフォルト値, サロゲート関数)
    """
    (nm, dv, sf) = (None, '', None)
    if not s or len(s) < 3: return (nm, dv, sf)
    ss = s[1:-1].strip() # omit '%'s
    # 式表現かどうかの判定(':'が含まれるか)
    toks = ss.split(':')
    if len(toks) > 1:
        # ':'以降の式をサロゲート関数に変換する
        sf = GetSurrogateFunc(toks[1])
        ss = toks[0]
    # パラメータ名とデフォルト値の分解
    toks = ss.split('!')
    if len(toks) > 1:
        dv = toks[1]
        ss = toks[0]
    nm = ss
    return (nm, dv, sf)

    
#----------------------------------------------------------------------
# process
def ConvTmpl(inpath, outpath, params):
    """
    テンプレートファイルの変換

    [in] inpath  入力ファイル(パラメータテンプレートファイル)のパス
    [in] outpath 出力ファイル(生成するパラメータファイル)のパス
    [in] params  パラメータ記述辞書
    戻り値 -> 真偽値
    """
    if not inpath or not outpath:
        return False

    try:
        fin = open(inpath, 'r')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % inpath )
        return False
    try:
        fout = open(outpath, 'w')
    except:
        sys.stderr.write('ERR: can not open file: %s\n' % outpath)
        fin.close()
        return False

    pat = re.compile('%.+?%') # '?' must be specified for minimal match
    for l in fin:
        res = pat.search(l)
        while res:
            (nm, dv, sf) = DecompPattern(res.group())
            valStr = ''
            if not nm in params:
                valStr = str(dv)
            else:
                valStr = str(params[nm])
            if sf:
                try:
                    ival = int(valStr)
                    valStr = str(sf(ival))
                except:
                    try:
                        fval = float(valStr)
                        valStr = str(sf(fval))
                    except:
                        pass
            l = pat.sub(valStr, l, 1)
            res = pat.search(l)
            continue # end of while(res)

        try:
            fout.write(l)
        except:
            sys.stderr.write('ERR: write failed to file: %s\n' % outpath)
            fin.close()
            fout.close()
            return False
        continue # end of for(l)

    fin.close()
    fout.close()
    return True
