#!/bin/sh


apps="app1 app2"


for each in ${apps[@]}; 
do
	echo "Starting up app: $each"
	echo "---------------------------------------"; 
	if [ -d $each ]; then 		 
		cd $each; 
		./RUN; 
		cd ..;		
	else
		echo "App $each doesn't exists, please verify"	
	fi 
done
