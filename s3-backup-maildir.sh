#!/bin/sh

# Backup Maildirs to Amazon S3
# Written by Abhinav korpal
# 12-08-2017

day=$(date +%A).tar.bz2
bucket="s3://s3.bucketname/"

function s3alert () {
	mail -s "Backup failure on: ${HOSTNAME}" xxxx@gmail.com
	exit 1
}

tar -cjf /root/Maildir-${day} /data/Maildir || s3alert
s3cmd put /root/Maildir-${day} ${bucket} || s3alert
rm /root/Maildir-${day} || s3alert
