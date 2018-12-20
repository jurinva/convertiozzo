#!/bin/bash

file=$1

echo $file

#grep tli- inventories_hosts.tli\ \(1\).ini | grep -v ';' | grep -v '\[' | grep -v 'vip\|prefix' > tli

uuid=$(uuidgen)
uuid=${uuid,,}

guid=$(uuidgen)
guid=${guid,,}

echo $uuid

> ./$file.yml
while read -r I; do
  uuid=$(uuidgen); uuid=${uuid,,}
  echo "    $uuid: 1" >> ./uuid.txt;
  desc=`echo $I | cut -d" " -f1`
  ip=`echo $I | cut -d"=" -f2`
  [[ $ip == '' ]]; ip=`host $desc | cut -d" " -f4`
  cat ./pac-template.txt | sed -e "s/{uuid}/$uuid/g" | sed -e "s/{desc}/$desc/g" | sed -e "s/{ip}/$ip/g" | sed -e "s/{port}/22/g" | sed -e "s/{parent}/72b7d72b-605d-4bd3-a6f6-d02a6c8e6119/g" | sed -e "s/{password}//g"
done < ./$file >> ./file.yml

echo -e "__PAC__EXPORTED__:
  children:
    $guid: 1
$guid:
  _is_group: 1
  _protected: 0
  children:"
cat uuid.txt >> $file.yml

echo -e "  description: Connection group 'TLI'
  name: TLI
  parent: __PAC__EXPORTED__
  screenshots: ~
" >> $file.yml