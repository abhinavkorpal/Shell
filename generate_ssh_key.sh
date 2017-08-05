#!/bin/bash
################################################################################
# Author:   Abhinav Korpal
# Date:     5/8/2017
# Program:
#   Generating SSH Keys
################################################################################

VERSION="0.1"

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin
export PATH

function displayErr()
{
    echo $1;
    exit 1;
}

function usage()
{
    echo 'Usage: '$0' Your_email'
    exit 1;
}

if [ "$#" -lt "1" ]; then
    usage $0
fi

test -e ~/.ssh/id_rsa && displayErr "Please remove or backup ~/.ssh/id_rsa file first"
test -e ~/.ssh/id_rsa.pub && displayErr "Please remove or backup ~/.ssh/id_rsa.pub file first"

mkdir -p ~/.ssh
ssh-keygen -t rsa -C $1
displayErr "Generating SSH Keys Completely"
