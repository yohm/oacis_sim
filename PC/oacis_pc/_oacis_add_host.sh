#!/bin/bash
if [ $# -lt 1 ]; then
    echo "usage: $0 {ffb | genesis | mdacp}"
    exit 1
fi

db_name=oacis_development

case $1 in
    "ffb" )
	if [ "$(mongo ${db_name} --eval 'printjson(db.hosts.count({"name": "ffb"}));' | tail -1 | tr -d '\r')" == "0" ]
	then
	    mongo ${db_name} --eval 'db.hosts.insert({"status" : "enabled", "port" : 22, "ssh_key" : "~/.ssh/id_rsa", "work_base_dir" : "~/ffb", "max_num_jobs" : 1, "polling_interval" : 5, "min_mpi_procs" : 1, "max_mpi_procs" : 4, "min_omp_threads" : 1, "max_omp_threads" : 4, "name" : "ffb", "hostname" : "ffb", "user" : "oacis"})'
	fi
    ;;
    "genesis" )
	if [ "$(mongo ${db_name} --eval 'printjson(db.hosts.count({"name": "genesis"}));' | tail -1 | tr -d '\r')" == "0" ]
	then
	    mongo ${db_name} --eval 'db.hosts.insert({"status" : "enabled", "port" : 22, "ssh_key" : "~/.ssh/id_rsa", "work_base_dir" : "~/genesis", "max_num_jobs" : 1, "polling_interval" : 5, "min_mpi_procs" : 8, "max_mpi_procs" : 8, "min_omp_threads" : 1, "max_omp_threads" : 4, "name" : "genesis", "hostname" : "genesis", "user" : "oacis"})'
	fi
    ;;
    "mdacp" )
	if [ "$(mongo ${db_name} --eval 'printjson(db.hosts.count({"name": "mdacp"}));' | tail -1 | tr -d '\r')" == "0" ]
	then
	    mongo ${db_name} --eval 'db.hosts.insert({"status" : "enabled", "port" : 22, "ssh_key" : "~/.ssh/id_rsa", "work_base_dir" : "~/mdacp", "max_num_jobs" : 1, "polling_interval" : 5, "min_mpi_procs" : 1, "max_mpi_procs" : 4, "min_omp_threads" : 1, "max_omp_threads" : 4, "name" : "mdacp", "hostname" : "mdacp", "user" : "oacis"})'
	fi
    ;;
    * ) echo "usage: $0 {ffb | genesis | mdacp}"
	exit 1 ;;
esac

exit 0
