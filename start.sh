#!/bin/bash

# Only proceed if we have a sync key
if [ -z "$SYNCKEY" ]; then
    echo "Using Sync Key $SYNCKEY"
    echo "No sync key found. Exiting."
    exit 1
fi

# Only proceed if a hostname was passed
if [ -z "$MYHOSTNAME" ]; then
    echo "No hostname defined. Exiting."
    exit 1
fi

# Do not accept read-write keys
# These keys starts with A or D
if [[ "$SYNCKEY" =~ ^(A|D).* ]]; then
  echo -e"\n\nRead-write key found.\nPlease only use read-only keys.\n\nAborting.\n\n"
  exit 1
fi

# Replace placeholders
sed -i "s/MYHOSTNAME/$MYHOSTNAME/g;s/DOCKERID/$(hostname)/g;s/MYSECRET/$SYNCKEY/g" /sync/btsync.conf

/usr/bin/btsync --config /sync/btsync.conf --nodaemon
