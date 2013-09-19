#!/bin/bash

#Check if RServe is running

sleepseconds=120
sleeptime=$(hostname --ip-address | tr -cd [:digit:] | awk '{printf "%d\n",$1}')
let sleeptime%=$sleepseconds
sleep $sleeptime

#host=$(hostname --fqdn)
host="uol-opalserver3.datashield.org"
running=$(ps aux | grep Rserve | grep -v "grep" | wc -l)

if [ "$running" -eq "1" ]
then
    rc=0
    check="RServe is running"
else
    rc=2
    check="RServe is NOT running"
fi

service_name="RServe"
token="uol00000sdhf48uhtrejhrfkasj9aw30"
url=http://nagios.brisskit.org/nrdp/


echo -e "$host\t$service_name\t$rc\t$check" | /local/nagios/plugins/send_nrdp.sh -u $url -t $token

