#!/bin/bash

# Checks for duplicate files (based on filename)
# Abhinav korpal
# 12-08-2017

# Usage
if [ -z "$1" ]; then
   echo "Usage: ./dupecheck.sh /dir"
fi

# Find files larger than 1MB
find $1 -size +10248576c -type f | while IFS= read file

do
   echo $(basename "$file")
done | sort | uniq -d
