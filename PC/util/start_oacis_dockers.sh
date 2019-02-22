#!/bin/bash
if [ "x$1" == "x-h" -o "x$1" == "x--help" ]; then
    echo "$(basename $0): start oacis docker container (from oacis_sim/oacis_pc)"
    echo "usage: $(basename $0) [-f|--ffb] [-g|--genesis] [-m|--mdacp]"
    echo " -f --ffb     start ffb docker container (from oacis_sim/ffb) simultaneously"
    echo " -g --genesis start genesis docker container (from oacis_sim/genesis) simultaneously"
    echo " -m --mdacp   start mdacp docker container (from oacis_sim/mdacp) simultaneously"
    exit 0
fi

_F="N"
_G="N"
_M="N"
while getopts fgm-: opt; do
    case ${opt} in
	"f" ) _F="Y" ;;
	"g" ) _G="Y" ;;
	"m" ) _M="Y" ;;
	"-" )
	    case "${OPTARG}" in
		"ffb" ) _F="Y" ;;
		"genesis" ) _G="Y" ;;
		"mdacp" ) _M="Y" ;;
	    esac
	    ;;
	* ) echo "usage: $(basename $0) [-f|--ffb] [-g|--genesis] [-m|--mdacp]"
	    exit 1 ;;
    esac
done

# oacis_sim base directory
_BD="`dirname $0`/.."
cd ${_BD}

# create oacis_sim/xsub docker image
if [ ${_F} == "Y" -o ${_G} == "Y" -o ${_M} == "Y" ]; then
    X=`docker images | grep 'oacis_sim/xsub' | wc -l`
    if [ ${X} -lt 1 ]; then
	(cd xsub; ./BUILD.sh)
    fi
fi

# create oacis_sim/ffb docker image, and start ffb docker container
if [ ${_F} == "Y" ]; then
    Y=`docker ps | grep 'oacis_sim/ffb' | wc -l`
    if [ ${Y} -lt 1 ]; then
	X=`docker images | grep 'oacis_sim/ffb' | wc -l`
	if [ ${X} -lt 1 ]; then
	    (cd ffb; ./BUILD.sh)
	fi
	(cd ffb; ./RUN.sh)
	echo "+ ffb docker container started."
    else
	echo "- ffb docker container has already started."
    fi
fi

# create oacis_sim/genesis docker image, and start genesis docker container
if [ ${_G} == "Y" ]; then
    Y=`docker ps | grep 'oacis_sim/genesis' | wc -l`
    if [ ${Y} -lt 1 ]; then
	X=`docker images | grep 'oacis_sim/genesis' | wc -l`
	if [ ${X} -lt 1 ]; then
	    (cd genesis; ./BUILD.sh)
	fi
	(cd genesis; ./RUN.sh)
	echo "+ genesis docker container started."
    else
	echo "- genesis docker container has already started."
    fi
fi

# create oacis_sim/mdacp docker image, and start mdacp docker container
if [ ${_M} == "Y" ]; then
    Y=`docker ps | grep 'oacis_sim/mdacp' | wc -l`
    if [ ${Y} -lt 1 ]; then
	X=`docker images | grep 'oacis_sim/mdacp' | wc -l`
	if [ ${X} -lt 1 ]; then
	    (cd mdacp; ./BUILD.sh)
	fi
	(cd mdacp; ./RUN.sh)
	echo "+ mdacp docker container started."
    else
	echo "- mdacp docker container has already started."
    fi
fi

# create oacis_sim/oacis_pc docker image, and start oacis docker container
Y=`docker ps | grep 'oacis_sim/oacis_pc' | wc -l`
if [ ${Y} -lt 1 ]; then
    Z=`docker images | grep 'oacis_sim/oacis_pc' | wc -l`
    if [ ${Z} -lt 1 ]; then
	# pull oacis base docker image of oacis_sim/oacis_pc
	X=`docker images | grep 'oacis/oacis' | wc -l`
	if [ ${X} -lt 1 ]; then
	    docker pull oacis/oacis
	fi
	(cd oacis_pc; ./BUILD.sh)
    fi
    (cd oacis_pc; ./RUN.sh)
    echo "+ oacis docker container started."
else
    echo "- oacis docker container has already started."
fi

# add host and simulator information
# - ffb
if [ ${_F} == "Y" ]; then
    Y=`docker ps | grep 'oacis_sim/ffb' | wc -l`
    if [ ${Y} -lt 1 ]; then
	echo "= ffb docker container not runnning."
    else
	(cd oacis_pc; ./setup_ffb.sh)
    fi
fi

# - genesis

# - mdacp
if [ ${_M} == "Y" ]; then
    Y=`docker ps | grep 'oacis_sim/mdacp' | wc -l`
    if [ ${Y} -lt 1 ]; then
	echo "= mdacp docker container not runnning."
    else
	(cd oacis_pc; ./setup_mdacp.sh)
    fi
fi

echo "--- system ready ---"
url=http://localhost:3000/
case `uname` in
    Linux  ) xdg-open ${url} ;;
    Darwin ) open ${url} ;;
    MINGW* )
	if [[ ! -z ${DOCKER_MACHINE_NAME} ]]; then
	    url=http://`docker-machine ip`:3000/
	fi
	start ${url}
	;;
esac

exit 0
