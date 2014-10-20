#!/bin/bash

# Required variables
SYNCKEY=$1
SHARENAME=$2
LOCALPATH=$3

# Make sure all variables exist
function check_variable {
  if [ -z $1 ]; then
    echo -e "\nError: Required variable missing.\n"
    echo -e "Usage:\n\tcreate_instance.sh sync-key share-name local-path\n"
    echo -e "sync-key:\tA read-only or encrypted key (e.g. 'BEV257UH5QN44VPKI5HL5XIDR7LSWK4MQ')"
    echo -e "share-name:\tThe name of the Docker container."
    echo -e "local-path:\tThe absolute path to where you want to store your data on the host system.\n\t\t(e.g. /home/vpetersson/btsync/someshare)"
   exit 1
  fi
}
check_variable $1
check_variable $2
check_variable $3

# Launch the instance
docker run -d \
    -p 55555 \
    -e "SYNCKEY=$SYNCKEY" \
    -e "MYHOSTNAME=$HOSTNAME" \
    --name "$SHARENAME" \
    -v $LOCALPATH:/sync/storage \
    --restart=always \
    vpetersson/btsync
