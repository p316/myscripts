#!/bin/sh

## load hosts and repository locations
source /Users/pradeep/Documents/dev-tools/hosts.sh
source /Users/pradeep/Documents/dev-tools/repositories.sh

if [ $# -eq 0 ]; then
  echo "No environment given"
  exit 1
fi

env=$1

if [ $env = "develop" ]; then
	hosts=${dev_hosts[@]}
elif [ $env = "test" ]; then 
	hosts=${test_hosts[@]}
else
	echo "Not a valid environment"
	exit 1
fi

folder_name=ent_$(date +"%Y-%m-%d")
base_folder="/Users/pradeep/Desktop/ent_Project/$folder_name"
base_file="/Users/pradeep/Desktop/ent_Project/${folder_name}.zip" 

[ -d $base_folder ] && rm -rf $base_folder || mkdir -p $base_folder
[ -f $base_file ] && rm $base_file || echo " "

echo  "Creating folder $folder_name"
mkdir -p $base_folder

find . -name *.jar -exec cp {} $base_folder \;
zip -jr $base_file $base_folder 
echo "$base_file created"

for each in ${hosts[@]}; do
	echo "Uploading to host: $each ..."
	scp -q $base_file emp_id@$each:/tmp 
done 