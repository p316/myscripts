#!/bin/sh


source ~/.bash_profile
appscripts="/Users/pradeep/Documents/ansibles/deploymenthub-nonprod"

#appscripts="/Users/pradeep/appscripts"
logs="/Users/pradeep/Documents/GitHub/my_scripts/logs"

count=1
f="execute.scpt"
rm $f; touch $f; chmod 755 $f
source=""
filename=""
yml_file="site.yml"
tags=""
email_tag=""

while getopts b:i:surpt option
do
case "${option}"
in
b | --branch ) var=${OPTARG}
  if [ "$var" == "develop" ]; then
    source="hosts/prj_name-DI_app_Develop"
  elif [ "$var" == "release" ]; then
    source="hosts/prj_name-DI_app_Release"
  elif [ "$var" == "it" ]; then
    source="hosts/prj_name-IT_app"
  elif [ "$var" == "uat" ]; then
    echo "UAT deploy requires prior notice to Business team, Are you sure you want to deploy (yes or no):\c"
    read confirm
    [ $confirm == 'yes' ] || exit 1
    source="hosts/prj_name-UAT_app"
  elif [ "$var" == "lt" ]; then
    source="hosts/prj_name-LT_app"
  fi
  ;;

i | --inventory ) filename=${OPTARG} ;;

p | --prop ) yml_file="properties_site.yml"
   tags=""
   email_tag="property only" ;;

r | --restart ) yml_file="properties_site.yml"
   tags="--tags=stop,start"
   email_tag="restart" ;;

s | --stop ) yml_file="properties_site.yml"
   tags="--tags=stop"
   email_tag="shutdown" ;;

u | --up) yml_file="properties_site.yml"
   tags="--tags=start"
   email_tag="startup" ;;

t | --time) yml_file="last_deploy.yml"
    appscripts="/Users/pradeep/Documents/GitHub/domain_scripts"
    tags=""
    email_tag="timestamp check";;

\?) echo "\nUsage:\n \
  ./deploy.sh -b develop -i list for regular deployment \n
  ./deploy.sh -b develop -i list -p for property only deployment \n
  ./deploy.sh -b develop -i list -s for shutdown \n
  ./deploy.sh -b develop -i list -r for restart \n
  ./deploy.sh -b develop -i list -u for startup \n
  ./deploy.sh -b develop -i list -t for timestamps \n"
  exit 1;;

esac
done

#echo $source
#echo $filename

#clear logs folder

if [ yml_file=="last_deploy.yml" ]; then
	rm -rf ./logs/*
fi



#########
generate_osascript() {

  deployables=("$@")

  echo "[AppleScript]" >>$f
  echo "tell application \"Terminal\"" >>$f
  echo "activate" >>$f

  for i in ${deployables[@]}; do
    echo "my makeTab()" >>$f
 #   echo -e '\033]2;SomeTitle\007'
    echo "do script \"cd $appscripts\" in tab $count of front window" >>$f
    echo "do script \"ansible-playbook -i $source -l $i --extra-vars \\\"ansible_sudo_pass=\$pass\\\" $yml_file -vv $tags\" in tab $count of front window" >>$f
    ((count += 1))
  done

  echo "end tell" >>$f
  echo "on makeTab()" >>$f
  echo "tell application \"System Events\" to keystroke \"t\" using {command down}" >>$f
  echo "delay 0.1" >>$f
  echo "end makeTab" >>$f
  echo "[AppleScript]" >>$f

}

#############

while read -r line; do
      [[ "$line" =~ ^#.*$ ]] && continue
  deployables+=($line)
done <"$filename"

generate_osascript "${deployables[@]}"

osascript $f


#cat list | mail -s "$var $email_tag deployment started on following apps" email@domain.com
