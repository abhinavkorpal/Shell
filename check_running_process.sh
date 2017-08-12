#!/bin/sh

## Script to check running process

host_name=`cat /etc/bashrc |grep PS1= |cut -d "@" -f2 |cut -d " " -f1`
host=`ifconfig |grep "addr:192" |cut -d ":" -f2 |cut -d " " -f1`

## Add Process Name

process=( snmpd )
no_proc=${#process[@]}
status=0
p_count=`expr $no_proc - 1`

function send_mail() {

                     echo " Sending Mail .."
                     curl --data "body=$msg &to=xxxxx@example.com &subject=$sub" https://mail.google.com/email/send
}


for (( i=0; i<=$p_count; i++ ));
do

proc_name=${process[i]}

echo " Checking for Service -- snmpd"

proc_status=`ps cax | grep -c $proc_name$`

if [ $proc_status -eq "1" ] || [ $proc_status -gt "1" ] ; then

    echo " snmpd is Running fine .."

else

         echo " $proc_name Is Not Running , Restarting $proc_name "

         /etc/init.d/snmpd status

         echo " Starting $proc_name Service .."

         /etc/init.d/snmpd start

                if [ $? == 0 ]; then

                   echo "snmpd Started Successfully ! "

                   msg="HOST Server-1 [192.168.2.4 ] ALERT : $proc_name Service Has Been Restarted Successfully ! "
                   sub="PROCESS ALERT : $host_name ->  snmpd UP "
                   send_mail
               else

                   echo " snmpd Failed to Start "
                   msg="HOST Server-1 [192.168.2.4 ] ALERT : $proc_name Service Has Down and Failed To ReStart"
                   sub="PROCESS ALERT : $host_name -> snmpd DOWN "
                   send_mail
              fi

fi

done
echo Jobcompleted `date` >> /mnt/log/snmpd_monitor.log
exit 0;
