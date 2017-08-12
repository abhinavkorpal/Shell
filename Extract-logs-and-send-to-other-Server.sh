#!/bin/sh
DATE=$(date --date='1 hour ago' +%F%H)
DATE1=$(date +%F)
DATE2=$(date +%Y%m%d%H)
DATE3=$(date +%Y%m%d)
DATE4=$(date --date='2 hour ago' +%F%H)
DATE5=$(date --date='1 hour ago' +%Y%m%d%H)
BOXES=(192.168.2.1 192.168.2.148 192.168.2.195 192.168.2.108 192.168.2.210 192.168.2.131 192.168.2.4 192.168.2.81)
DIR=/log/tomcat
FILE=/log/tomcat/log.log

[ ! -d $DATE ] && mkdir $DATE

for BOX in ${BOXES[@]}
  do
    ssh root@$BOX "/log/tomcat/extract.sh;"
    scp  root@$BOX:$DIR/log.$BOX.log  $DATE
    ssh root@$BOX "rm -rf $DIR/log.$BOX.log;"

  done
sort $DATE/*  > $DATE/log.$DATE5.log
sed -i 's/^ *//' $DATE/log.$DATE5.log
if [[ -s $DATE/log.$DATE5.log ]] ; then
bzip2 $DATE/log.$DATE5.log
if [[ `ssh root@example.com test -d /var/logs/$DATE3/$DATE5 && echo exists > /dev/null` ]] ; then
scp $DATE/log.$DATE5.log.bz2 root@example.com:/var/logs/$DATE3/$DATE5
else
ssh root@example.com "mkdir -p /var/logs/$DATE3/$DATE5"
scp $DATE/log.$DATE5.log.bz2 root@example.com:/var/logs/$DATE3/$DATE5
rm -rf $DATE4
fi;
else
for BOX in ${BOXES[@]}
  do
    ssh root@$BOX "grep " $(date --date='1 hour ago' '+%H').*SITE_USER" /log/tomcat/log.log.$DATE1 | sed 's/^.*:://' > $DIR/log.$BOX.log;"
    scp  root@$BOX:$DIR/log.$BOX.log  $DATE
    ssh root@$BOX "rm -rf $DIR/log.$BOX.log;"
  done
sort $DATE/*  > $DATE/log.$DATE5.log
sed -i 's/^ *//' $DATE/log.$DATE5.log
if [[ -s $DATE/log.$DATE5.log ]] ; then
bzip2 $DATE/log.$DATE5.log
if [[ `ssh root@example.com test -d /var/logs/$DATE3/$DATE5 && echo exists > /dev/null` ]] ; then
scp $DATE/log.$DATE5.log.bz2 root@example.com:/var/logs/$DATE3/$DATE5
else
ssh root@example.com "mkdir -p /var/logs/$DATE3/$DATE5"
scp $DATE/log.$DATE5.log.bz2 root@example.com:/var/logs/$DATE3/$DATE5
fi;
else
msg="No logs found at $DATE5 for user"
email="xxxx@example.com"

curl --data "body=$msg &to=$email &subject=$msg" https://www.google.com/email/send
fi;
fi;
