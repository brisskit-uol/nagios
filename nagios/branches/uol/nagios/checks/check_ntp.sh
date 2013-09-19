#!/bin/bash

sleepseconds=120
sleeptime=$(hostname --ip-address | tr -cd [:digit:] | awk '{printf "%d\n",$1}')
let sleeptime%=$sleepseconds
sleep $sleeptime

#host=$(hostname --fqdn)
host="uol-opalserver3.datashield.org"
check=$(/usr/lib/nagios/plugins/check_ntp_time -H localhost -w 0.5 -c 1.0)
rc=$?
service_name="NTP"
token="uol00000sdhf48uhtrejhrfkasj9aw30"
url=http://nagios.brisskit.org/nrdp/


echo -e "$host\t$service_name\t$rc\t$check" | /local/nagios/plugins/send_nrdp.sh -u $url -t $token

