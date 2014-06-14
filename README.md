# BitTorrent Sync running in Docker

tl;dr Run BitTorrent Sync isolated within a Docker container.

# Installation

To install this container, simply run:

    docker pull vpetersson/btsync

# Usage

This Docker container relies on the environment variable `SYNCKEY`. For your own safety, only use read-only keys (or encrypted keys).

Assuming you actually want to permanently store the data, the container also requires that you pass on a local storage path (outside of the container) where you store the data (`/local/storagepath:` below). This may be either a regular path or an encrypted volume.

    docker run -d -e "SYNCKEY=YourSyncKey" -v /local/storagepath:/sync/ vpetersson/btsync

Each container is designed to only run one share, so you will need to spin up one container per share.

# Credits

 * [billt2006](https://github.com/billt2006/docker-btsync) for the initial inspiration.
