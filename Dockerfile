FROM ubuntu:14.04
MAINTAINER Viktor Petersson <info@viktorpetersson.com>

# Update apt-cache and install wget
RUN apt-get update
RUN apt-get install -y wget

# Fetch btsync
RUN wget -O /tmp/btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
RUN tar xvfz /tmp/btsync.tar.gz -C /usr/bin/
RUN rm /tmp/btsync.tar.gz
RUN rm -f /usr/bin/LICENSE.TXT

# Add config file
ADD btsync.conf /sync/btsync.conf
ADD start.sh /start.sh

# Run the boot script
CMD /start.sh

EXPOSE 55555/tcp
