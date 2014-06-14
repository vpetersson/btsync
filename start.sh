#!/bin/bash


# Make sure the sync folder exist
mkdir -p /sync

# Only proceed if we have a sync key
if [ -n "$SYNCKEY" ]; then
    echo "Using Sync Key $SYNCKEY"
    sed -i "s/REPLACEME/$SYNCKEY/g" /etc/btsync.conf

    /usr/bin/btsync --config /etc/btsync.conf --nodaemon
else
    echo "No sync key found. Exiting."
    exit 1
fi
