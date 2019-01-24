#!/bin/bash
if [ "x$1" == "x-h" -o "x$1" == "x--help" ]; then
    echo "$(basename $0): stop all docker containers (from oacis_sim/* image)"
    echo "usage: $(basename $0) [-D]"
    echo "  -D  delete oacis_sim/* docker image(s) simultaneously"
    exit 0
fi

DI="N"
if [ "x$1" == "x-D" ]; then
    DI="Y"
elif [ ! -z $1 ]; then
    echo "$(basename $0): illegal option -- $1"
    echo "usage: $(basename $0) [-D]"
    exit 1
fi

docker ps | grep oacis_sim | while read line; do
    CID=`echo $line | awk '{print $1}'`
    docker stop $CID
done

if [ $DI == "Y" ]; then
    docker images | grep oacis_sim | while read line; do
	IID=`echo $line | awk '{print $3}'`
	docker rmi $IID
    done
fi

if [ "`docker network ls | grep oacis-network`x" != "x" ]; then
    docker network rm oacis-network
fi

exit 0
