#
# Glusterfs container, built on ubuntu
#
# Unfortunately mainly due to centos / fedora builds not running on my mac
# nor rancherOS nor ubuntu infrastructure
#
# VERSION               1.0.0
FROM picoded/ubuntu-base

# Setup glusterfs apt-get 
RUN apt-get install -y software-properties-common python-software-properties && \
	add-apt-repository ppa:gluster/glusterfs-3.7;

# Install glusterfs
RUN apt-get update && \
	apt-get install -y glusterfs-server;

# Overwrite entrypoint and default command
ENTRYPOINT [ "/entrypoint/primer.sh", "glusterd", "-N" ]
CMD []