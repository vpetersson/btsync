# BitTorrent Sync running in Docker

tl;dr Run [BitTorrent Sync](http://www.bittorrent.com/sync) isolated within a Docker container.

# Installation

To install this container, simply run:

    docker pull vpetersson/btsync

# Usage

This Docker container relies on the environment variable `SYNCKEY`. For your own safety, only use read-only keys (or encrypted keys).

Assuming you actually want to permanently store the data, the container also requires that you pass on a local storage path (outside of the container) where you store the data (`/local/storagepath` below). This may be either a regular path or an encrypted volume.

The name variable is optional, but recommended such that you can identify what share the instance is running.

    docker run -d \
        -p 55555 \
        -e "SYNCKEY=YourSyncKey" \
        -e "MYHOSTNAME=$HOSTNAME" \
        --name "NameOfYourShare" \
        -v /local/storagepath:/sync/storage \
        vpetersson/btsync

Each container is designed to only run one share, so you will need to spin up one container per share.

Alternatively, you can use the script `create_instance.sh` to create your instances.

    wget https://raw.githubusercontent.com/vpetersson/btsync/master/create_instance.sh
    chmod +x create_instance.sh
    ./create_instance.sh sync-key share-name local-path

# Credits

 * [billt2006](https://github.com/billt2006/docker-btsync) for the initial inspiration.
