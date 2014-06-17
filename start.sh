#!/bin/bash

# Only proceed if we have a sync key
if [ -z "$SYNCKEY" ]; then
    echo "Using Sync Key $SYNCKEY"
    echo "No sync key found. Exiting."
    exit 1
fi

# Only proceed if we have a sync key
if [ -z "$MYHOSTNAME" ]; then
    echo "No hostname defined. Exiting."
    exit 1
fi

# Replace placeholders
sed -i "s/MYHOSTNAME/$MYHOSTNAME/g;s/DOCKERID/$(hostname)/g;s/MYSECRET/$SYNCKEY/g" /etc/btsync.conf

/usr/bin/btsync --config /sync/btsync.conf --nodaemon
