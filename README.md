docker-utils
============

Helper scripts when working with docker containers. For now there's only one script called docker_cleanup.sh, to delete old stopped containers. The script has the following options:

    -m    Delete all containers that are "Minutes old"
    -h    Delete all containers that are "Hours old"
    -d    Delete all containers that are "Days old"
    -w    Delete all containers that are "Weeks old"
    -a    Delete all containers

Each option will delete the stopped containers that are reported by `docker ps -a` with the same age in the CREATED column. The -a option will delete all stopped containers.
