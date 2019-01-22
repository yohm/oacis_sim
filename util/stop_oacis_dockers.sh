#!/bin/bash
DC="N"
DI="N"
if [ "x$1" == "x-d" ]; then
    DC="Y"
elif [ "x$1" == "x-D" ]; then
    DC="Y"
    DI="Y"
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
