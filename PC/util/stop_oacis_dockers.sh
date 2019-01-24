#!/bin/bash
if [ "x$1" == "x-h" -o "x$1" == "x--help" ]; then
    echo "$0: stop all docker containers named oacis_sim/*"
    echo "usage: $0 [-d | -D]"
    echo "  -d  delete docker containers"
    echo "  -D  delete docker images"
    exit 0
fi
DC="N"
DI="N"
if [ "x$1" == "x-d" ]; then
    DC="Y"
elif [ "x$1" == "x-D" ]; then
    DC="Y"
    DI="Y"
elif [ ! -z $1 ]; then
    echo "$0: illegal option -- $1"
    echo "usage: $0 [-d | -D]"
    exit 1
fi

docker ps | grep oacis_sim | while read line; do
    CID=`echo $line | awk '{print $1}'`
    docker stop $CID
done

if [ $DC == "Y" ]; then
    docker ps -a | grep oacis_sim | while read line; do
	CID=`echo $line | awk '{print $1}'`
	docker rm $CID
    done
fi

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
