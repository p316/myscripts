#!/bin/sh

echo "Last updated : $(date +"%m-%d-%Y %r") (Auto refreshes every 60 seconds)"

if [ $# -gt 0 ]; then   // ensure to add vips, hosts files as arguments
  for filename in "$@"; do
    if [ -f $filename ]; then
      header=1
      echo ""
      while read -r line; do
	[[ "$line" =~ ^#.*$ ]] && continue   // ignore commented lines
        app_name=$(echo $line | cut -d' ' -f1)
        host_name=$(echo $line | cut -d' ' -f2)
		if [[ $filename == *"vips"* ]] ; then
          		cmd=$(curl -vk --connect-timeout 5 https://$host_name &>/dev/null  )
	      	else
          		#cmd=$(nc -z $host_name 8443 2>&1)
          		cmd=$(curl -vk --connect-timeout 5 https://$host_name:8443 &>/dev/null)
          		if [ $cmd -ne 0 ] ; then
				cmd=$(curl -vk --connect-timeout 5 https://$host_name:8443 &>/dev/null)
			fi
       		fi
        res=$?
        if [ $header -eq 1 ] ; then
          status="STATUS"
        elif [ $res -eq 0 ]; then
          status="ALIVE"
        else
          status="NOT_ALIVE"
        fi
        printf '%25s%45s%10s\n' $app_name $host_name $status
        header=0
      done <"$filename"

    else
      echo "File not found : $filename"
    fi
  done
  #	mail -a 'Content-type: text/html; charset="us-ascii"' email@domain.com < status_check.txt
  #	mail -s "Status check on all hosts"  email@domain.com  < status_check.txt
  exit 1
else
  echo "Please input hosts list file"
  exit 1
fi
echo ""
