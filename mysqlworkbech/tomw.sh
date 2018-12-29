#!/bin/bash

file=$1

echo $file



#echo $uuid

function server-instances() {
#  while read -r J; do
#    uuid=$(uuidgen); uuid=${uuid,,}
    uuid2=$(uuidgen); uuid1=`echo $uuid2 | cut -d" " -f1`
#    hostname=`echo $I | cut -d" " -f1 | cut -d"=" -f2`
#    user=`echo $I | cut -d" " -f2 | cut -d"=" -f2`
#    pass=`echo $I | cut -d" " -f3 | cut -d"=" -f2`
#    ip=`echo $I | cut -d"=" -f2`
#    [[ $ip == '' ]]; ip=`host $desc | cut -d" " -f4`
    cat ./server-instances-template.txt | sed -e "s/{uuid}/$uuid/g" | sed -e "s/{hostname}/$hostname/g" >> ./server-instances.xml
}

> ./server-instances.xml
echo -e "<?xml version=\"1.0\"?>\n<data grt_format=\"2.0\">" > server-instances.xml

> ./connections.xml
echo -e "<?xml version=\"1.0\"?>\n<data grt_format=\"2.0\">" > connections.xml

while read -r I; do
  uuid=$(uuidgen); uuid=${uuid,,}
  uuid1=$(uuidgen); uuid1=`echo $uuid1 | cut -d" " -f1`
  hostname=`echo $I | cut -d" " -f1 | cut -d"=" -f2`
  user=`echo $I | cut -d" " -f2 | cut -d"=" -f2`
  pass=`echo $I | cut -d" " -f3 | cut -d"=" -f2`
#  ip=`echo $I | cut -d"=" -f2`
#  [[ $ip == '' ]]; ip=`host $desc | cut -d" " -f4`
  server-instances
  cat ./connections-template.txt | sed -e "s/{uuid}/$uuid/g" | sed -e "s/{hostname}/$hostname/g" | sed -e "s/{user}/$user/g" | sed -e "s/{password}/$pass/g"
done < ./$file >> ./connections.xml

echo "</data>" >> ./connections.xml


  echo "</data>" >> ./server-instances.xml


