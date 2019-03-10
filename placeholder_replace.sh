#!/bin/sh
#alias dos2unix="sed -i 's/'\"\$(printf '\015')\"'//g' "
while read LINE
do
        key=`echo "$LINE" | cut -f1 -d","`;
        echo "key=$key"
        value=`echo "$LINE" | cut -f 2- -d","`;
        echo "value=$value"
        #grep -lr "$key" | xargs sed -i "s|$key|$value|g";
        rm -rf ./prop_to_replace.txt
        grep -r $key * >>prop_to_replace.txt
        while read PROP
        do
                file=`echo $PROP |cut -f1 -d":"`;
                echo "file=$file"
                sed -i "" "s|$key|${value}|g" $file
                awk 'BEGIN{RS="\1";ORS="";getline;gsub("\r","");print>ARGV[1]}' $file
        done<./prop_to_replace.txt
        rm -rf ./prop_to_replace.txt
#       \rm  -rf `find ./ -name "*-e*"`
done<../Propertiescsv1.0.csv
