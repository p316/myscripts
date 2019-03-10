#!/bin/sh
source ~/.bash_profile


ent_dir="/Users/pradeep/Desktop/ent_Project/"

## load hosts and repository locations
source $(pwd)/hosts.sh
source $(pwd)/repositories.sh

## ensure require arguments are provided
if [ $# -ne 2 ]; then
  echo "No environment or application info. submitted"
  exit 1
else
  	env=$1
	app=$2
fi

case "$1" in
        dev)
            hosts=${dev_hosts[@]}
            ;;
         
        test)
            hosts=${test_hosts[@]}
            ;;
        
        mock)
            hosts=${mock_hosts[@]}
            ;;
            
        *)
            echo "Usage: $0 {dev|test|mock} {ent|java|zoo|solr}"
            exit 1 
esac

case "$2" in
        ent)
        	## create folder name based on date
            folder_name=ent_$(date +"%Y-%m-%d")
		 	base_folder="$ent_dir/$folder_name"
			base_file="ent_dir/${folder_name}.zip" 
			
			## if already folder and zip files are  created, delete it
			if [ -d $base_folder ] ; then  rm -rf $base_folder ; fi
			if [ -f $base_file ] ; then rm $base_file ; fi
 
 			## create folder and zip 
			echo  "Creating folder $folder_name"
			mkdir -p $base_folder
			find . -name *.jar -exec cp {} $base_folder \;
			zip -jr $ent_file $base_folder  ;
			
			base_file=$ent_file	;
            ;;
         
        java)
        	base_file=$java_file           
            ;;
         
        zoo)
        	base_file=$zoo_keeper_file           
            ;;
                      
    	 solr)
    	 	base_file=$solr_file           
            ;;
            
        *)
            echo "Usage: $0 {dev|test|mock} {ent|java|zoo|solr}"
            exit 1
            
esac

echo "Uploading $base_file to hosts: ${hosts[@]}"

for each in ${hosts[@]}; do
	scp $base_file $myid@$each:/tmp 
done 
