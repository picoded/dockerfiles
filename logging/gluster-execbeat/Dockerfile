# Executes a command, and pushes it to elasticsearch
# 
# Typically from the gluster cluster (which is running on this node)
#
# VERSION               1.0.1
#
FROM picoded/execbeat

####################################################
#
# execbeat installation
#
####################################################

# Docker execbeat build install
RUN sudo apt-get install -y software-properties-common && \
	sudo apt-get update && \
	sudo apt-get install -y glusterfs-server;

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
	chmod +x /entrypoint/glusterfs.sh;

# Log gluster version
RUN glusterd --version

# The final execution
ENTRYPOINT ["/entrypoint/primer.sh", "/entrypoint/glusterfs.sh", "/usr/share/execbeat/bin/execbeat"]
CMD [ "-v", "-e", "-path.config=/etc/execbeat/" ]