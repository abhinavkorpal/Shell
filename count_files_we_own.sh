#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Usage: $0 file ..."
  exit 1
fi

echo "$0 counts the lines of code"
l=0
n=0
m=0
for f in $*
do
  if [ -0 $f ]
  then
      l=`wc -l $f | sed 's/^\([0-9]*\).*$/\1/'`
      echo "$f: $l"
      n=$[ $n + 1 ]
      s=$[ $s + $l ]
  else
      continue
  fi
done

echo "$n files in total, with $s lines in total"
