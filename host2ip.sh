#!/bin/bash

filename=$1
rm ips.txt &

while read -r line; do
	ip=$(nslookup $line | tail -2 |  cut -d " " -f 2 |tr -d '\n')
	touch ips.txt
	echo $ip >> ips.txt
done <"$filename"

echo -e "ips.txt is generated."
