#!/bin/sh
source ~/.bash_profile
src_loc=$(realpath $0)
base_loc=${src_loc%/*}
echo $src_loc
echo $base_loc

branch=$1
user=$domain_id   # assign your domain user ID

[ "$user" ] || echo "Please assign \"user\" variable with your Company ID"
[ "$user" ] || exit 1

if [ $# -eq 0 ]; then
  echo "No branch given"
  exit 1
fi

#echo "${log_file##*/}" # last string
#echo "${log_file%/*}"  # everything before last string
#folders=$(ls -d */)

repos="Repo1 repo2 repo3"

download_repo() {
  repo=$1
  echo "\nRepo not found locally, fetching from Git"
  git checkout $branch
  git clone -b $branch git@github..domain.com:$user/$repo.git
  cd $repo
  git remote add upstream git@github..domain.com:repo_name/$repo.git
  cd ..
}


### MAIN starts here

for i in ${repos[@]}; do

    echo "\n$i "
    echo ---------------------------------------------------------------

    [ -d $i ]  || download_repo $i

    cd $i
    git checkout $branch
    git reset --hard
    git clean -df
    git reset --merge
    git pull upstream $branch
    git push origin $branch
    cd ..
done

cd $base_loc
