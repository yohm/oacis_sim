#!/bin/bash
if [ "x$1" == "x-h" -o "x$1" == "x--help" ]; then
    echo "$(basename $0): stop all docker containers (from oacis_sim/* image)"
    echo "usage: $(basename $0) [-d [-i]]"
    echo "  -d  delete oacis_sim/* docker image(s) simultaneously"
    echo "  -i  request confirmation before delete each docker image"
    exit 0
fi

DI="N"
_I="N"
while getopts di opt; do
    case ${opt} in
	"d" ) DI="Y" ;;
	"i" ) _I="Y" ;;
	* ) echo "usage: $(basename $0) [-d [-i]]"
	    exit 1 ;;
    esac
done

# stop docker container(s)
echo "stopping docker containers ..."
docker ps | grep oacis_sim | while read line; do
    CID=`echo $line | awk '{print $1}'`
    docker stop ${CID}
    echo "- ${CID} stopped."
done

# delete docker network 'oacis-network'
if [ "`docker network ls | grep oacis-network`x" != "x" ]; then
    docker network rm oacis-network
    echo "- oacis-network removed."
fi

# delete docker image(s)
if [ ${DI} == "Y" ]; then
    iids=`docker images | grep oacis_sim | awk '{print $3}'`
    for IID in ${iids}; do
	imn=`docker images | grep ${IID} | awk '{print $1}'`
	if [ ${_I} == "Y" ]; then
	    read -p "= delete ${imn} (${IID}) ?[Y/n]:" ans
	    case ${ans} in
		'' | [Yy]* )
		    docker rmi ${IID}
		    echo "- ${IID} deleted." ;;
		* ) continue ;;
	    esac
	else
	    docker rmi ${IID}
	    echo "- ${IID} deleted."
	fi	
    done
fi

exit 0
