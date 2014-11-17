FROM ubuntu:14.04
MAINTAINER Viktor Petersson <info@viktorpetersson.com>

# Update apt-cache and install wget
RUN apt-get update && apt-get install -y wget && apt-get clean

# Fetch btsync
RUN wget -O /tmp/btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable && tar xvfz /tmp/btsync.tar.gz -C /usr/bin/ && rm /tmp/btsync.tar.gz && rm -f /usr/bin/LICENSE.TXT

# Print out the version (there is no version arg, so we grep for it)
RUN /usr/bin/btsync --foobar | grep "BitTorrent Sync"

# Add config file
ADD includes/btsync.conf /sync/btsync.conf
ADD includes/start.sh /start.sh

# Run the boot script
CMD /start.sh

EXPOSE 55555/tcp
