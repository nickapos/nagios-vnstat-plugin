#~/bin/bash

#argument order -M monthly/daily -R receive/transmit 
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

while getopts M:R: OPTION
do 
    case $OPTION in 
        M) 
            MON_DAI=$OPTARG 
            ;; 
        R) 
            REC_TRA=$OPTARG 
            ;; 
    esac 
done 

echo "Flags MONDAI" $MON_DAI " REC_TRA" $REC_TRA 

if [[ -z $MON_DAI ]] || [[ -z $REC_TRA ]]
then 
    echo "Please provide arguments for both -M and -R options"
    exit 1 

elif [ "$MON_DAI" = "M" ]|| [ "$MON_DAI" = "D" ] && [ "$REC_TRA" = "R" ] ||
    [ "$REC_TRA" = "T" ]
then
    echo "Flags MONDAI" $MON_DAI " REC_TRA" $REC_TRA 

fi
