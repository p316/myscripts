# apple_scripts

to run check_VMs.sh

./check_VMs.sh {vips,hosts}_DI.txt > status_check_di.txt


vips_DI.txt should contain VIP URLs
hosts_DI.txt should contain hosts information

-----------

Automated ansible deployment
Usage:
   ./deploy.sh -b develop -i list for regular deployment 

  ./deploy.sh -b develop -i list -p for property only deployment 

  ./deploy.sh -b develop -i list -s for shutdown 

  ./deploy.sh -b develop -i list -r for restart 

  ./deploy.sh -b develop -i list -u for startup 

  ./deploy.sh -b develop -i list -t for timestamps 
  ----------

Checkout app and also do git update
Usage:
  
    ./update_repo.sh

------------

Check hosts/vip status
Usage: 
    ./check_VMs.sh   filename (hosts/vips list)
