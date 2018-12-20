#!/bin/bash

while read -r I; do 
  uuid=$(uuidgen); uuid=${uuid,,}
  desc=`echo $I | cut -d" " -f1`
  ip=`echo $I | cut -d"=" -f2`; [[ $ip == '' ]]; ip=`host $desc | cut -d" " -f4`
  echo $desc $ip
done < ./gt > /tmp/gt.list
