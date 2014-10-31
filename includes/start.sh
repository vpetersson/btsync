#!/bin/bash

echo "Starting btsync Docker container..."

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

# Make sure the folder exists
mkdir -p /sync/storage

# Manually manage the exclude list
rm -rf /sync/storage/.sync

# Simplify appending files
function ignoreList {
  mkdir -p /sync/storage/.sync
  echo "$1" >> /sync/storage/.sync/IgnoreList
}

ignoreList "_Store"
ignoreList ".Spotlight-V100"
ignoreList ".Trashes"
ignoreList "~*"
ignoreList "ehthumbs.db"
ignoreList "desktop.ini"
ignoreList "Thumbs.db"
ignoreList "com.apple.FinderInfo"
ignoreList "com.apple.ResourceFork"
ignoreList "*.swp"

# Replace placeholders
sed -i "s/MYHOSTNAME/$MYHOSTNAME/g;s/DOCKERID/$(hostname)/g;s/MYSECRET/$SYNCKEY/g" /sync/btsync.conf

/usr/bin/btsync --config /sync/btsync.conf --nodaemon
