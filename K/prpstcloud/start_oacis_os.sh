#!/bin/bash

# invoke ssh-agen locally, add private key of K
_A=`ssh-add -l | grep "id_rsa.K" | wc -l`
if [ ${_A} -lt 1 ]; then
    kf="id_rsa.K"
    if [ ! -f ${kf} ]; then
        read -p "specify the private key file of K: " kf
        if [ "x${kf}" == "x" -o ! -f ${kf} ]; then
            echo "invalid key file specified, exit."
            exit 1
        fi
    fi
    eval `ssh-agent`
    ssh-add ${kf}
    if [ $? != 0 ]; then
        exit 1
    fi
    echo "invoked ssh-agent: SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"
else
    echo "refer existed ssh-agent: SSH_AUTH_SOCK=${SSH_AUTH_SOCK}"
fi

# adjust .ssh/config
if [ -d ${HOME}/.ssh ]; then
	if [ -f ${HOME}/.ssh/config ]; then
		xs=`grep StrictHostKeyChecking ${HOME}/.ssh/config | wc -l`
		if [ ${xs} -lt 1 ]; then
			echo 'StrictHostKeyChecking no' >> ${HOME}/.ssh/config
		fi
	else
		echo 'StrictHostKeyChecking no' > ${HOME}/.ssh/config
		chmod go-rwx ${HOME}/.ssh/config
	fi
fi

# oacis_sim/K/prpstcloud base directory
_BD="`dirname $0`"
cd ${_BD}

# invoke setup_oacis_os.sh
./setup_oacis_os.sh

echo "+ invoking web browser ..."
url=http://localhost:3000/
case `uname` in
    Linux  ) xdg-open ${url} ;;
    Darwin ) open ${url} ;;
    MINGW* ) start ${url} ;;
esac

exit 0

