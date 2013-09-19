#!/bin/bash

#Slightly modified check script to live on the UoL LAMP stack.

sleepseconds=120
sleeptime=$(hostname --ip-address | tr -cd [:digit:] | awk '{printf "%d\n",$1}')
let sleeptime%=$sleepseconds
sleep $sleeptime

#host=$(hostname --fqdn)
host=uol-opalserver3.datashield.org
check=$(/usr/bin/uptime)
rc=$?
token="uol00000sdhf48uhtrejhrfkasj9aw30"
url=http://nagios.brisskit.org/nrdp/


echo -e "$host\t$rc\t$check" | /local/nagios/plugins/send_nrdp.sh -u $url -t $token
