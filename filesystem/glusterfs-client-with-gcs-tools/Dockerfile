#
# Glusterfs client node, built on ubuntu
#
# Unfortunately mainly due to centos / fedora builds not running on my mac
# nor rancherOS nor ubuntu infrastructure
#
# VERSION               1.0.0
FROM picoded/ubuntu-base

ENV DEBIAN_FRONTEND noninteractive

# Setup glusterfs apt-get (This step will be deprecated by ubuntu-base)
RUN apt-get install -y software-properties-common python-software-properties && \
	add-apt-repository ppa:gluster/glusterfs-3.12;

# Install glusterfs
RUN apt-get update && \
	apt-get install -y glusterfs-client;

#
# Get the required google-cloud-sdk stuff
#

RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list;

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;
RUN sudo apt-get update && sudo apt-get install -y google-cloud-sdk && apt-get clean;

#
# Environment variables to configure glusterfs-client
#

# Gluster FS mounting point inside this container
ENV GFS_MOUNT='/workspace'
# Glusterfs volume to mount
ENV GFS_VOLUME='glusterfs'
# Glusterfs hostname to fetch configuration on the volume on
# NOTE : Subsequent IO read/write will directly connect to the respective volume
ENV GFS_STARTING_HOST='glusterfs'
# The logging level for client node
ENV GFS_LOG_LEVEL='INFO'
# The logging file, note that this is automatically cleared at start
# And tailed to output stream
ENV GFS_LOG_FILE='/var/log/glusterfs/glusterfs.log'
# Direct IO mode is only for system that already handles caching on its own
# And what pure random read/write performance. Beyond such use cases this can paradoxically be slower
# Examples include databases
ENV GFS_DIRECT_IO='disable' 
# Additional glusterfs options, see its man docs (its better then offical docs)
# https://manpages.debian.org/unstable/glusterfs-client/fusermount-glusterfs.8.en.html
ENV GFS_OPTIONS=''
# @TODO - Enables / Disable glsuterfs log tailing
ENV GFS_LOGTAIL='true'
# Commands to execute prior to aptget install/upgrade on bootup
ENV GFS_PRESCRIPT=""
# Commands to execute after aptget install/upgrade on bootup
ENV GFS_POSTSCRIPT=""

# Path of anchor file to validate if exists,
# If this value is set, and the file does not exists
# the docker entrypoint script will terminate and fail.
ENV GFS_ANCHOR_FILE_CHECK_PATH=""

# Delay to wait for, prior to crashing the container
ENV GFS_ANCHOR_FILE_FAILURE_DELAY="10s"


#
# The actual runtime script
#
RUN echo '#!/bin/bash' > /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '# GFS_PRESCRIPT run'                                                        >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ -n "$GFS_PRESCRIPT" ] ; then'                                          >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "### Running GFS_PRESCRIPT"'                                        >> /entrypoint/glusterfs-client.sh && \
	echo '   eval "$GFS_PRESCRIPT";'                                                  >> /entrypoint/glusterfs-client.sh && \
	echo 'fi'                                                                         >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '# GFS_STARTING_HOST run'                                                    >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ -n "$GFS_STARTING_HOST" ] ; then'                                      >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "##> Start of picoded/glusterfs : glusterfs-client.sh"'             >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '   # Reset glusterfs logs'                                                  >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "" >  "${GFS_LOG_FILE}";'                                           >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "##> Mounting Glusterfs Filesystem"'                                >> /entrypoint/glusterfs-client.sh && \
	echo '   mkdir -p "${GFS_MOUNT}"'                                                 >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '   # glusterfs-client mount command'                                        >> /entrypoint/glusterfs-client.sh && \
	echo '   mount -t glusterfs -o log-level="${GFS_LOG_LEVEL}",log-file="${GFS_LOG_FILE}",direct-io-mode="${GFS_DIRECT_IO}" ${GFS_OPTIONS} "${GFS_STARTING_HOST}:/${GFS_VOLUME}" "${GFS_MOUNT}"' >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'fi'                                                                         >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '# Anchor file check'                                                        >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ -n "$GFS_ANCHOR_FILE_CHECK_PATH" ] ; then'                             >> /entrypoint/glusterfs-client.sh && \
	echo '   if [ -e "$GFS_ANCHOR_FILE_CHECK_PATH" ] ; then'                          >> /entrypoint/glusterfs-client.sh && \
	echo '      echo "### Anchor file validated : $GFS_ANCHOR_FILE_CHECK_PATH"'       >> /entrypoint/glusterfs-client.sh && \
	echo '   else'                                                                    >> /entrypoint/glusterfs-client.sh && \
	echo '      echo "### [ERROR] Anchor file missing : $GFS_ANCHOR_FILE_CHECK_PATH"' >> /entrypoint/glusterfs-client.sh && \
	echo '      echo "### [ERROR] sleeping for $GFS_ANCHOR_FILE_FAILURE_DELAY"'       >> /entrypoint/glusterfs-client.sh && \
	echo '      sleep $GFS_ANCHOR_FILE_FAILURE_DELAY;'                                >> /entrypoint/glusterfs-client.sh && \
	echo '      echo "### [FATAL] exiting with 404"'                                  >> /entrypoint/glusterfs-client.sh && \
	echo '      exit 404;'                                                            >> /entrypoint/glusterfs-client.sh && \
	echo '   fi'                                                                      >> /entrypoint/glusterfs-client.sh && \
	echo 'fi'                                                                         >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '# GFS_POSTSCRIPT run'                                                       >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ -n "$GFS_POSTSCRIPT" ] ; then'                                         >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "### Running GFS_POSTSCRIPT"'                                       >> /entrypoint/glusterfs-client.sh && \
	echo '   eval "$GFS_POSTSCRIPT";'                                                 >> /entrypoint/glusterfs-client.sh && \
	echo 'fi'                                                                         >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'echo "##> Chaining picoded/glusterfs : glusterfs-client.sh"'                >> /entrypoint/glusterfs-client.sh && \
	echo 'exec "$@"'                                                                  >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'if [[  -n "$GFS_STARTING_HOST" && ( "$GFS_LOGTAIL" = true  ||  "$GFS_LOGTAIL" = "true" ) ]] ; then'         >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "##> Eternal log tail of picoded/glusterfs : glusterfs-clients.sh"' >> /entrypoint/glusterfs-client.sh && \
	echo '   tail -f "${GFS_LOG_FILE}";'                                              >> /entrypoint/glusterfs-client.sh && \
	echo 'fi'                                                                         >> /entrypoint/glusterfs-client.sh && \
	chmod +x /entrypoint/glusterfs-client.sh;

# Chain up the entrypoints
ENTRYPOINT [ "/entrypoint/primer.sh",  "/entrypoint/glusterfs-client.sh" ]