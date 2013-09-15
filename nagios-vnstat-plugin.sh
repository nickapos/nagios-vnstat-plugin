#~/bin/bash

#argument order -MD monthly/daily -RT receive/transmit 
monthlyIncoming=`vnstat |grep estimated|awk  '{print $2}'|head -1`
monthlyIncomingGrade=`vnstat |grep estimated|awk  '{print $3}'|head -1`
echo "monthly average incoming " $monthlyIncoming $monthlyIncomingGrade

monthlyTransmitting=`vnstat |grep estimated|awk  '{print $5}'|head -1`
monthlyIncomingGrade=`vnstat |grep estimated|awk  '{print $6}'|head -1`
echo "monthly average transmitting " $monthlyTransmitting $monthlyIncomingGrade


dailyIncoming=`vnstat |grep estimated|awk  '{print $2}'|tail -1`
dailyIncomingGrade=`vnstat |grep estimated|awk  '{print $3}'|tail -1`
echo "daily incoming average " $dailyIncoming $dailyIncomingGrade

dailyTransmitting=`vnstat |grep estimated|awk  '{print $5}'|tail -1`
dailyTransmittingGrade=`vnstat |grep estimated|awk  '{print $3}'|tail -1`
echo "daily transmitting averate " $dailyTransmitting $dailyTransmittingGrade



MON_DAI=
REC_TRA=

while getopts “MD:RT:” OPTION
do 
    case $OPTION in 
        MD) 
            MON_DAI=$OPTARG 
            ;; 
        RD) 
            REC_TRA=$OPTARG 
            ;; 
    esac 
done 

if [[ -z $MON_DAI ]] || [[ -z $REC_TRA ]]
then 
    echo "Please provide arguments for both -MD and -RD options"
    exit 1 
fi
