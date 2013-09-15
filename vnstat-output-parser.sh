#~/bin/bash
vnstat_output="$(vnstat|grep estimated)"

#argument order -M monthly/daily -R receive/transmit 
monthlyIncoming=$(echo "$vnstat_output"|awk  '{print $2}'|head -1)
monthlyIncomingGrade=$(echo "$vnstat_output"|awk  '{print $3}'|head -1)
#echo "monthly average incoming " $monthlyIncoming $monthlyIncomingGrade

monthlyTransmitting=$(echo "$vnstat_output"|awk  '{print $5}'|head -1)
monthlyTransmittingGrade=$(echo "$vnstat_output"|awk  '{print $6}'|head -1)
#echo "monthly average transmitting " $monthlyTransmitting $monthlyIncomingGrade


dailyIncoming=$(echo "$vnstat_output"|awk  '{print $2}'|tail -1)
dailyIncomingGrade=$(echo "$vnstat_output"|awk  '{print $3}'|tail -1)
#echo "daily incoming average " $dailyIncoming $dailyIncomingGrade

dailyTransmitting=$(echo "$vnstat_output"|awk  '{print $5}'|tail -1)
dailyTransmittingGrade=$(echo "$vnstat_output"|awk  '{print $6}'|tail -1)
#echo "daily transmitting averate " $dailyTransmitting $dailyTransmittingGrade



MON_DAI=
REC_TRA=
DISPLAYUNITS=

while getopts M:R:U OPTION
do 
    case $OPTION in 
        M) 
            MON_DAI=$OPTARG 
            ;; 
        R) 
            REC_TRA=$OPTARG 
            ;; 
        U)
            DISPLAYUNITS="TRUE"
    esac 
done 

function displayUnits()
{
if [ "$DISPLAYUNITS" = "TRUE" ]
then
    echo $1
fi
exit 0
}

if [[ -z $MON_DAI ]] || [[ -z $REC_TRA ]]
then 
    echo "Please provide arguments for both -M and -R options"
    exit 3 
#monthly receive
elif [ "$MON_DAI" = "M" ] && [ "$REC_TRA" = "R" ]
then
    echo $monthlyIncoming `displayUnits $monthlyIncomingGrade`
    exit 0
#daily reveice
elif [ "$MON_DAI" = "D" ] && [ "$REC_TRA" = "R" ]
then
    echo $dailyIncoming `displayUnits $dailyIncomingGrade`
    exit 0
#daily transmit
elif [ "$MON_DAI" = "D" ] && [ "$REC_TRA" = "T" ]
then
    echo $dailyTransmitting `displayUnits $dailyTransmittingGrade`
    exit 0
#monthly transmit
elif [ "$MON_DAI" = "M" ] && [ "$REC_TRA" = "T" ]
then
    echo $monthlyTransmitting `displayUnits $monthlyIncomingGrade `
    exit 0
else
    echo "The acceptable arguments for -M is M or D and -R is R or T"
    exit 3
fi


