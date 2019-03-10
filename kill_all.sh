#!/bin/sh
## force kill any processes

source ~/.bash_profile


var="\| "
while getopts azs option
do
case "${option}"
in
	z | --zookeeper ) var=${OPTARG}
 		var="zookeeper" 
    ;;

	s | --solr ) var=${OPTARG}
 		var="solr" 
    ;;
	a | --all ) var=${OPTARG}
 		var="solr\|zookeeper" 
    ;;


\?) echo "\nUsage:\n \
  ./kill_all -a  \n
  ./kill_all -z  \n
  ./kill_all -s  \n"
  exit 1;;

esac
done

ps -ef | grep -e $var
ps -ef |grep -e $var | awk '{print $2}' | xargs kill -9