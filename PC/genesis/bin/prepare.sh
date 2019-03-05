#!/bin/bash
genesis_dir=${HOME}/genesis
_IN="_input.json"
if [ ! "x$1" == "x" ]; then
  _IN=$1
fi
_T=`cat ${_IN} | python -m json.tool | awk -F':' '/temp_case/{print $2}' | sed -e 's/,//g' -e 's/ //g'`
if [ "x${_T}" == "x" ]; then
  _T=3
fi
_P=`cat ${_IN} | python -m json.tool | awk -F':' '/pres_case/{print $2}' | sed -e 's/,//g' -e 's/ //g'`
if [ "x${_P}" == "x" ]; then
  _P=3
fi

case ${_T} in
  "1" ) _D="dataT250" ;;
  "2" ) _D="dataT275" ;;
  "3" ) _D="dataT300" ;;
  "4" ) _D="dataT325" ;;
  "5" ) _D="dataT350" ;;
  * ) echo "invalid temp_case" 1>&2
      exit 1 ;;
esac

case ${_P} in
  "1" ) _DDIR="${_D}P08" ;;
  "2" ) _DDIR="${_D}P09" ;;
  "3" ) _DDIR="${_D}P10" ;;
  "4" ) _DDIR="${_D}P11" ;;
  "5" ) _DDIR="${_D}P12" ;;
  * ) echo "invalid pres_case" 1>&2
      exit 1 ;;
esac

rm -rf 4_equilibration
mkdir 4_equilibration
cp ${genesis_dir}/data/${_DDIR}/* 4_equilibration/
cp -r ${genesis_dir}/data/1_setup ./
cp ${genesis_dir}/data/run.inp.tmpl ./

cp ${genesis_dir}/bin/*.py ./
cp ${genesis_dir}/bin/run.sh ./
cp ${genesis_dir}/bin/spdyn ./
python genesis_prep.py

exit 0

