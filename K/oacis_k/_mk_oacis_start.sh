#!/bin/bash
# mk_oacis_start.sh: to make ~oacis/oacis_start.sh

S=""
if [ ${SOCKS5_USER:-x} != "x" ]; then
    S="export SOCKS5_USER=${SOCKS5_USER}"
fi
if [ ${SOCKS5_PASSWD:-x} != "x" ]; then
    S="`echo $S`
export SOCKS5_PASSWD=${SOCKS5_PASSWD}"
fi

cat <<EOF >/home/oacis/oacis_start.sh
#!/bin/bash
export BUNDLE_PATH=/usr/local/bundle
export BUNDLE_APP_CONFIG=/usr/local/bundle
$S
cd /home/oacis/oacis
if [ "\$(mongo oacis_development --eval 'printjson(db.hosts.count({"name": "K"}));' | tail -1 | tr -d '\r')" == "0" ]
then
  mongo oacis_development --eval 'db.hosts.insert({"status" : "enabled", "port" : 22, "max_num_jobs" : 10, "polling_interval" : 10, "min_mpi_procs" : 1, "max_mpi_procs" : 64, "min_omp_threads" : 1, "max_omp_threads" : 8, "name" : "K", "hostname" : "K", "user" : "${KUSER}"})'
fi
bundle exec rake daemon:restart
#wait forever
tail -f /dev/null &
child=\$!
wait "\$child"
EOF

exit 0
