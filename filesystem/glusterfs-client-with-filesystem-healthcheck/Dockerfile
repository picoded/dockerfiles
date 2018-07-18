#
# Glusterfs client node, built on ubuntu
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
	apt-get install -y glusterfs-client;

# Install git stuff
RUN apt-get update && apt-get install -y git && apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && apt-get clean;

#
# Environment variables to configure glusterfs-client
#

#
# Git repo to clone from
# Note, You can add user/pass by doing :
# "https://user:pass@github.com/picoded/dockerfiles.git"
#
ENV GIT_REPO "https://github.com/picoded/dockerfiles.git"

# Branch or commit hash to checkout from
ENV GIT_COMMIT "master"

# The folder name to clone into, default is the /workspace folder itself (or ".")
# Note this only works as a relative path to /workspace, do not use blank
ENV GIT_FOLDER "."

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

#
# The actual runtime script
#
RUN echo '#!/bin/bash'                                                               > /entrypoint/glusterfs-client.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/glusterfs-client.sh && \
	echo 'echo "### Start of picoded/git-cloner : entrypoint/glusterfs-client.sh"'    >> /entrypoint/glusterfs-client.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ -n "$GFS_PRESCRIPT" ]; then '                                          >> /entrypoint/glusterfs-client.sh && \
	echo '   echo "### Running GFS_PRESCRIPT"'                                        >> /entrypoint/glusterfs-client.sh && \
	echo '   eval "$GFS_PRESCRIPT";'                                                  >> /entrypoint/glusterfs-client.sh && \
	echo 'fi '                                                                        >> /entrypoint/glusterfs-client.sh && \
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
	echo '# Enters the /workspace'                                                    >> /entrypoint/glusterfs-client.sh && \
	echo 'cd /workspace;'                                                             >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '# Ensures the git repo is cloned'                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ ! -d "$GIT_FOLDER/.git" ]; then '                                      >> /entrypoint/glusterfs-client.sh && \
	echo '   git clone --recursive "$GIT_REPO" "$GIT_FOLDER";'                        >> /entrypoint/glusterfs-client.sh && \
	echo 'fi '                                                                        >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo '# Enter git repo and pull updates (if needed)'                              >> /entrypoint/glusterfs-client.sh && \
	echo 'cd "$GIT_FOLDER"'                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'git fetch;'                                                                 >> /entrypoint/glusterfs-client.sh && \
	echo 'git checkout "$GIT_COMMIT";'                                                >> /entrypoint/glusterfs-client.sh && \
	echo 'git pull;'                                                                  >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'if [ -n "$GFS_POSTSCRIPT" ]; then '                                         >> /entrypoint/glusterfs-client.sh && \
	echo '   eval "$GFS_POSTSCRIPT";'                                                 >> /entrypoint/glusterfs-client.sh && \
	echo 'fi '                                                                        >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/glusterfs-client.sh && \
	echo 'echo "### Finished picoded/git-cloner : entrypoint/glusterfs-client.sh"'    >> /entrypoint/glusterfs-client.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/glusterfs-client.sh && \
	echo ''                                                                           >> /entrypoint/glusterfs-client.sh && \
	echo 'cd "/workspace/$GIT_FOLDER/"'                                               >> /entrypoint/glusterfs-client.sh && \
	echo 'exec "$@"'                                                                  >> /entrypoint/glusterfs-client.sh && \
	chmod +x /entrypoint/glusterfs-client.sh;

# Chain up the entrypoints
ENTRYPOINT [ "/entrypoint/primer.sh",  "/entrypoint/glusterfs-client.sh" ]