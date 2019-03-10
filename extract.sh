#!/bin/sh
source ~/.bash_profile
src_loc=$(realpath $0)
base_loc=${src_loc%/*}

logs_path="./logs"

branch=$1
user=$emp_id   # assign your emp user ID

[ "$user" ] || echo "Please assign \"user\" variable with your emp ID"
[ "$user" ] || exit 1


#echo "${log_file##*/}" # last string
#echo "${log_file%/*}"  # everything before last string
files=$(ls  logs)

### MAIN starts here

for i in ${files[@]}; do
	hostname=$(head -1 $logs_path/$i | tail -1)
	app=$(head -2 $logs_path/$i | tail -1)
	timestamp=$(head -3 $logs_path/$i |tail -1 | awk '{print $1 " " $2 " " $3}')
  filepath=$(head -3 $logs_path/$i | tail -1 | awk '{print $4}')

	version=${filepath##*/}

# echo $app
# echo $hostname
# echo $version
# echo $timestamp
printf '%29s%35s%51s\n' $app $hostname $version

done
