#!/bin/sh
set -x
## software sources
java_file="openjdk-11.0.2_linux-x64_bin.tar"
zoo_keeper_file="zookeeper-3.4.12.tar.gz"
solr_file="solr-6.6.0.tgz"
base_path="~/softwares"

soft_list="$java_file $zoo_keeper_file $solr_file"


# cd $base_path

for each in ${soft_list[@]}; do
	[[ -f /tmp/${each} ]] && cp /tmp/$each $base_path || echo "File not found - /tmp/$each" 
	[[ $? = 0 ]] &&  tar -zxvf $base_path/$each -C $base_path || 
done