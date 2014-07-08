#!/bin/bash
# 
# Bash script to cleanup old docker containers. It has different parameters to 
# limit the age of the stopped containers to be deleted. See the usage function 
# for a list of options.
# Author: Juan Luis Baptiste <juan.baptiste@gmail.com>
# License: GNU GPL v2
#

DOCKER_BIN="docker"
#If you don't need sudo, comment this
SUDO_BIN="sudo"

use () {
cat << EOF
Use: $0 -h -d -w -a

Delete old Docker containers.

OPTIONS:

-m    Delete all containers that are "Minutes old"
-h    Delete all containers that are "Hours old"
-d    Delete all containers that are "Days old"
-w    Delete all containers that are "Weeks old"
-a    Delete all containers

EOF
}


delete_container () {
    if [ "$1" != "" ];
    then
	TIME=$1    
	echo "Deleting containers that are \"$TIME\" old..." 	
	
	if [ "`$SUDO_BIN $DOCKER_BIN ps -a | grep "Exited" | grep \"$TIME\"`" != "" ];
	then
	    echo -e "Deleted container ID's:\n `$SUDO_BIN $DOCKER_BIN ps -a | grep "Exited" | grep "$TIME" | awk '{print $1}' | xargs $SUDO_BIN $DOCKER_BIN rm`"
	else
	    echo "No containers with that age to be deleted."
	    exit 0
	fi
    fi  
}    

minutes_ago () {
  delete_container "minute ago"
  delete_container "minutes ago"
} 

hours_ago () {
  delete_container "hours ago"
} 

days_ago () {
  delete_container "days ago"
} 

weeks_ago () {
  delete_container "weeks ago"
} 

delete_all () {
  echo "Deleting containers ALL stopped containers..." 
  if [ "`$SUDO_BIN $DOCKER_BIN ps -a | grep "Exited"`" != "" ];
    then
	echo -e "Deleted container ID's:\n `$SUDO_BIN $DOCKER_BIN ps -a | grep "Exited" | awk '{print $1}' | xargs $SUDO_BIN $DOCKER_BIN rm`"
    else
	echo "No containers to be deleted."
	exit 0
    fi
} 


while getopts "mhdwa" OPTION
  do
    case $OPTION in
        m)
            minutes_ago
            exit
            ;;    
        h)
            hours_ago
            exit
            ;;
        d)
            days_ago
            exit
            ;;
        w)
            weeks_ago
            exit
            ;;
        a)
            delete_all
            exit
            ;;
        ?)
            use
            exit
            ;;
    esac
 done           
