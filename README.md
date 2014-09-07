docker-utils
============

Helper scripts when working with docker containers. 

### docker_cleanup.sh

This script helps with the deletion of old containers. The script has the following options:

    -m    Delete all containers that are "Minutes old"
    -h    Delete all containers that are "Hours old"
    -d    Delete all containers that are "Days old"
    -w    Delete all containers that are "Weeks old"
    -a    Delete all containers

Each option will delete the stopped containers that are reported by `docker ps -a` with the same age in the CREATED column. The -a option will delete all stopped containers.

### docker_attach.sh

This script will attach to a running container using nsenter. First use docker ps to get the container ID and then run it like:

    sudo docker ps (find the container ID lets say $PID) 
    sudo ./docker_attach $PID


### Bash aliases
You can setup bash aliases like the following ones to make it easier to use these scripts. Add the following lines to your ~/.bashrc file (adjust paths accordingly):

    alias dclean="$HOME/git/docker-utils/scripts/docker_cleanup.sh $1"
    alias dattach="$HOME/git/docker-utils/scripts/docker_attach.sh $1"
