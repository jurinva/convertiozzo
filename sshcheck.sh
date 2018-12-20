#!/bin/bash

f=$1

> $f.check
l=''

while read -r J; do
  h=`echo $J | cut -d" " -f1`
  l="$l $h"
done < $f.list

#echo $l

for I in $l; do
  host=`echo $I | cut -d" " -f1`
  ssh -o "StrictHostKeyChecking no" -q $host "exit"
  if [ $? -eq 0 ]; then r=true; else r=false; fi
  echo $host $r >> $f.check
done
