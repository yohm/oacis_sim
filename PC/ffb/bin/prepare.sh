#!/bin/bash
ffb_dir=${HOME}/ffb
_IN="_input.json"
if [ ! "x$1" == "x" ]; then
  _IN=$1
fi
_MD=`cat ${_IN} | python -m json.tool | awk -F':' '/MESHDV/{print $2}' | sed -e 's/,//g' -e 's/ //g'`
if [ "x${_MD}" == "x" ]; then
  _MD=1
fi
_MS=`cat ${_IN} | python -m json.tool | awk -F':' '/MESHSZ/{print $2}' | sed -e 's/,//g' -e 's/ //g'`
if [ "x${_MS}" == "x" ]; then
  _MS=1
fi
case ${_MS} in
  "1" ) _D="DATA_23x23x23_" ;;
  "2" ) _D="DATA_46x46x46_" ;;
  "3" ) _D="DATA_92x92x92_" ;;
  * ) echo "invalid MESHSZ: ${_MS}" 1>&2
      exit 1 ;;
esac
_DDIR=${ffb_dir}/data/${_D}${_MD}para
cp ${_DDIR}/* .

cp ${ffb_dir}/tmpl/*.py .
cp ${ffb_dir}/tmpl/PARMLES3X.tmpl .
python ffb_prep.py

cp ${ffb_dir}/bin/* .

exit 0

