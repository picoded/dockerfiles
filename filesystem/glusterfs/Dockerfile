#
# Glusterfs container, built on ubuntu
#
# Unfortunately mainly due to centos / fedora builds not running on my mac
# nor rancherOS nor ubuntu infrastructure
#
# VERSION               1.0.0
FROM picoded/ubuntu-base

# Setup glusterfs apt-get (This step will be deprecated by ubuntu-base)
RUN apt-get install -y software-properties-common python-software-properties && \
	add-apt-repository ppa:gluster/glusterfs-3.12;

# Install glusterfs
RUN apt-get update && \
	apt-get install -y glusterfs-server;

#
# Prepares the glusterfs script
#
RUN echo '#!/bin/bash'                                                                  > /entrypoint/glusterfs.sh && \
	echo ''                                                                             >> /entrypoint/glusterfs.sh && \
	echo 'echo "##> Start of picoded/glusterfs : entrypoint/glusterfs.sh"'              >> /entrypoint/glusterfs.sh && \
	echo ''                                                                             >> /entrypoint/glusterfs.sh && \
	echo '# Enters the /workspace'                                                      >> /entrypoint/glusterfs.sh && \
	echo 'cd /workspace;'                                                               >> /entrypoint/glusterfs.sh && \
	echo ''                                                                             >> /entrypoint/glusterfs.sh && \
	echo '# Reset glusterd logs'                                                        >> /entrypoint/glusterfs.sh && \
	echo 'echo "" >  /var/log/glusterfs/glusterfs.log;'                                 >> /entrypoint/glusterfs.sh && \
	echo ''                                                                             >> /entrypoint/glusterfs.sh && \
	echo '# Startup glusterd'                                                           >> /entrypoint/glusterfs.sh && \
	echo 'glusterd --version;'                                                          >> /entrypoint/glusterfs.sh && \
	echo 'glusterd --log-file=/var/log/glusterfs/glusterfs.log;'                        >> /entrypoint/glusterfs.sh && \
	echo ''                                                                             >> /entrypoint/glusterfs.sh && \
	echo 'echo "##> Chaining picoded/glusterfs : entrypoint/glusterfs.sh"'              >> /entrypoint/glusterfs.sh && \
	echo 'exec "$@"'                                                                    >> /entrypoint/glusterfs.sh && \
	echo ''                                                                             >> /entrypoint/glusterfs.sh && \
	echo 'echo "##> Eternal log tail of picoded/glusterfs : entrypoint/glusterfs.sh"'   >> /entrypoint/glusterfs.sh && \
	echo 'tail -f /var/log/glusterfs/glusterfs.log & wait;'                             >> /entrypoint/glusterfs.sh && \
	chmod +x /entrypoint/glusterfs.sh;

# Overwrite entrypoint and default command (which is blank)
ENTRYPOINT [ "/entrypoint/primer.sh", "/entrypoint/glusterfs.sh" ]
CMD []
