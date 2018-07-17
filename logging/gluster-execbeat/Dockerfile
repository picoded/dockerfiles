# Executes a command, and pushes it to elasticsearch
# 
# Typically from the gluster cluster (which is running on this node)
#
# VERSION               1.0.1
#
FROM picoded/execbeat

#-----------------------------------------------
#
# Execbeat settings
#
#-----------------------------------------------

# The execution command, without arguments
ENV EX_CMD     "gluster"

# The parameters to pass the command, note that this assume that spaces, 
# are a seperate param, without the quotes. For example.
#
# ENV_PARAMS="argA argB argC"
#
# Refrence: https://github.com/christiangalsterer/execbeat/issues/7
#
# Unfortunately this crashes / fail if its completely blank
# So ensure that atleast a " " blank string of one space is used
ENV EX_PARAMS  "volume status"

# The excution frequency
ENV EX_CRON "@every 60s"

# The execbeat document type
ENV EX_DOC_TYPE "gluster-volume-status"

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