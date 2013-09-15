#!/bin/bash


# float number comparison
function fcomp() {
    awk -v n1=$1 -v n2=$2 'BEGIN{ if (n1<n2) exit 0; exit 1}'
}


network_monitoring=`vnstat-output-parser.sh $1 $2 $3 $4 $5`
network_monitoring_with_unit=`vnstat-output-parser.sh $1 $2 $3 $4 $5 -U`
if fcomp $network_monitoring  50 
then 
    echo "OK - $network_monitoring_with_unit" 
    exit 0 
elif fcomp $network_monitoring 100 
then 
    echo "WARNING - $network_monitoring_with_unit" 
    exit 1 
elif fcomp $network_monitoring  4000  
then echo "CRITICAL - $network_monitoring_with_unit" 
    exit 2 
else 
    echo "UNKNOWN - $network_monitoring_with_unit" 
    exit 3 
fi

