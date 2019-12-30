#!/bin/bash

#For everything to work best, minimum set of packages to install
# apt-get install perl vim tree mlocate htop rsync iptables-persistent

if [ $# -ne 1 ]
then
    echo I need one variable !
    echo The variable should be the IP or server_name to bootstrap :
    echo Ex: ./bootstrap.sh 10.0.0.1
    echo Ex: ./bootstrap.sh web.foo.bar
fi

DST=$1
RET=`ping -c 1 -t 1 $DST ; echo $?`
if [ $RET = 1 ]
then
    echo "Host $DST is unreachable. Stopping operations ..."
fi

echo "Starting copy ..."
rsync -a ../bash/.bashrc                         $DST:/root/
rsync -a ../vim/.vimrc                           $DST:/root/
rsync -a ../iptables/iptables-rules.v4           $DST:/etc/iptables/rules
rsync -a ../iptables/iptables-status             $DST:/usr/local/bin/
rsync -a ../iptables/iptables-persistent.conf    $DST:/etc/default/
rsync -a ../iptables/iptables-persistent         $DST:/usr/sbin/
rsync -a ../iptables/iptables-persistent.service $DST:/lib/systemd/system/
rsync -a ../snmp/snmpd.conf                      $DST:/etc/snmp/
echo "... copy finished"
