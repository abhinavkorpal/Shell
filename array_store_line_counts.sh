#!/bin/bash
# Counting the number of lines in a list of files
# function version

get_files () {
  files="`ls *.[ch]`"
}

count_lines () {
  f=$1
  l=`wc -l $f | sed 's/^\([0-9]*\).*$/\1/'`
}

if [ $# -ge 1 ]
then
  echo "Usage: $0"
  exit 1
fi

IFS=$'\012'

echo "$0 counts the lines of code"

l=0
n=0
s=0

get_files

for f in $files
do
        count_lines $f
        echo "$f: $l"loc
        file[$n]=$f
        lines[$n]=$l
        n=$[ $n + 1 ]
        s=$[ $s + $l ]
done

echo "$n files in total, with $s lines in total"
i=5
echo "The $i-th file was ${file[$i]} with ${lines[$i]} lines"
