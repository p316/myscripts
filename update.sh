#!/bin/sh
source ~/.bash_profile

if [ $# -eq 0 ]; then
  echo "No branch given"
  exit 1
fi

branch=$1
#folders=$(ls -dl */ | awk '{print $9}'); 
source /Users/pradeep/Documents//dev-tools/apps.sh


for each in ${folders[@]}; 
do
	echo " "
	echo $each  ;
	echo "--------"; 
	if [ -d $each ]; then 		 
		echo $each  ; 
		cd $each;

 
		if [ $2 == 'pull' ]; then 	 
			git clean -f; 
			git stash; 
			git reset --hard HEAD  
			git pull origin $branch;
		elif [ $2 == 'push' ]; then 
			git checkout $branch  		
			git add . ; git commit -m "update" ; git push origin $branch
		fi

		cd ..;
 	
		
	else
		echo "Repo $each doesn't exits, downloading from git@github..domain.com:ent/$each"
		git clone -b $branch git@github..domain.com:ent/$each  
		
	fi
done

find . -type d -name "resources" -exec cp /Users/pradeep/Google\ Drive/Documents/ent\ Project/ent-local-keystore.jks  {} \;
find . -name ent-local-keystore.jks  | xargs md5
