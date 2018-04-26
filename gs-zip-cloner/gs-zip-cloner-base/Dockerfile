# clones a git repo,
# do whatever you want with it after cloning
#
# VERSION               1.0.1
#
FROM picoded/glusterfs-client

ENV DEBIAN_FRONTEND noninteractive

#
# Get the required google-cloud-sdk stuff
#

RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list;

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;
RUN sudo apt-get update && sudo apt-get install -y google-cloud-sdk && apt-get clean;

#
# Google storage url / credentials handling
#

# zip file to download from Google storage
ENV GS_URL "gs://<bucket-name>/<sub-directory>/<somezipfile>.zip"

# Google storage .json credential service account file to use
ENV GS_CRED_FILE '/gs-cred.json'

# Google storage .json credential service account content
# Leave this blank, if mounting and using the credential file directly
ENV GS_CRED_CONTENT ''

#
# Zip file handling
#

# Branch or commit hash to checkout from
ENV ZIP_FILE "master.zip"

# This is the run script, called before git clone/pull
ENV ZIP_PRESCRIPT ""

# This is the run script, called after git clone/pull
ENV ZIP_POSTSCRIPT ""

# The folder to export into within "/workspace"
ENV ZIP_FOLDER ""

# Remove former content prior to unzip
# @TODO : To implement


#
# Overwrite the GFS environment config used by default
#

# Gluster FS mounting point inside this container
ENV GFS_MOUNT='/storage'
# Glusterfs volume to mount
ENV GFS_VOLUME=''
# Glusterfs hostname to fetch configuration on the volume on
# NOTE : Subsequent IO read/write will directly connect to the respective volume
ENV GFS_STARTING_HOST=''

#
# Prepares the gs zip cloner script
#
RUN echo '#!/bin/bash'                                                                > /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo 'echo "### Start of picoded/zip-cloner : entrypoint/zip-cloner.sh"'          >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Enters the /workspace'                                                    >> /entrypoint/zip-cloner.sh && \
	echo 'cd /workspace;'                                                             >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'if [ -n "$ZIP_PRESCRIPT" ]; then '                                          >> /entrypoint/zip-cloner.sh && \
	echo '   echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '   echo "### prescript of picoded/zip-cloner"'                              >> /entrypoint/zip-cloner.sh && \
	echo '   echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '   eval "$ZIP_PRESCRIPT";'                                                  >> /entrypoint/zip-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Enters the /workspace'                                                    >> /entrypoint/zip-cloner.sh && \
	echo 'cd /workspace;'                                                             >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Ensures the old file is removed'                                          >> /entrypoint/zip-cloner.sh && \
	echo 'rm -f "/tmp/$ZIP_FILE";'                                                    >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Setup the credential file'                                                >> /entrypoint/zip-cloner.sh && \
	echo 'if [ -n "$GS_CRED_CONTENT" ]; then '                                        >> /entrypoint/zip-cloner.sh && \
	echo '   echo "$GS_CRED_CONTENT" > "$GS_CRED_FILE";'                              >> /entrypoint/zip-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Redownload the file'                                                      >> /entrypoint/zip-cloner.sh && \
	echo 'gsutil -o "Credentials:gs_service_key_file=$GS_CRED_FILE" cp "$GS_URL" /tmp/$ZIP_FILE;' >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo 'echo "### Unzipping of the file package"'                                   >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Unzip the file contents'                                                  >> /entrypoint/zip-cloner.sh && \
	echo 'unzip -o "/tmp/$ZIP_FILE" -d "/workspace/$ZIP_FOLDER/";'                    >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'if [ -n "$ZIP_POSTSCRIPT" ]; then '                                         >> /entrypoint/zip-cloner.sh && \
	echo '   echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '   echo "### postscript of picoded/zip-cloner"'                             >> /entrypoint/zip-cloner.sh && \
	echo '   echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '   cd "/workspace/$ZIP_FOLDER/"'                                            >> /entrypoint/zip-cloner.sh && \
	echo '   eval "$ZIP_POSTSCRIPT";'                                                 >> /entrypoint/zip-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo 'echo "### Finished picoded/zip-cloner : entrypoint/zip-cloner.sh"'          >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'cd "/workspace/$ZIP_FOLDER/"'                                               >> /entrypoint/zip-cloner.sh && \
	echo 'exec "$@"'                                                                  >> /entrypoint/zip-cloner.sh && \
	chmod +x /entrypoint/zip-cloner.sh;
	
#
# Useful for build debugging
#
# RUN cat /entrypoint/zip-cloner.sh;

#
# Runs with entry point and command
#
ENTRYPOINT ["/entrypoint/primer.sh",  "/entrypoint/glusterfs-client.sh", "/entrypoint/zip-cloner.sh"] 
CMD echo "hello world : run your actual command here"
