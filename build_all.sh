#!/bin/sh
source ~/.bash_profile

if [ $# -eq 0 ]; then
  echo "No branch given"
  exit 1
fi

branch=$1
 
source /Users/pradeep/Documents/apps.sh

case "$1" in
        dev|develop)
           branch="develop"
            ;;
        devops)
        	branch="devops"
        	;;            
        *)
            echo "Usage: $0 {dev or develop |devops}"
            exit 1            
esac


for each in ${folders[@]}; 
do
	echo " "
	echo $each  ;
	echo "--------"; 
	if [ -d $each ]; then 		 
		echo $each  ; 
		cd $each;  		
		# git clean -f; 
# 		git stash; 
# 		git reset --hard HEAD
# 		git checkout $branch;  
 		git pull origin $branch;
 		find . -type d -name "resources" -exec cp /Users/pradeep/Desktop/ent_Project/ent-local-keystore.jks {} \;
		find . -name ent-local-keystore.jks  | xargs md5
		
		mvn -T 4 clean install -DskipTests 	
		cd ..; 	
		
	else
		echo "Repo $each doesn't exits, downloading from git@github..domain.com:ent/$each"
		git clone git@github..domain.com:ent/$each 
		
		find . -type d -name "resources" -exec cp /Users/pradeep/Desktop/ent_Project/ent-local-keystore.jks {} \;
		find . -name ent-local-keystore.jks  | xargs md5
		
		mvn -T 4 clean install -DskipTests
		cd ..;
		
	fi	
	 
done

