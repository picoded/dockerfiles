# clones a git repo,
# do whatever you want with it after cloning
#
# VERSION               1.0.1
#
FROM picoded/ubuntu-base

#
# Get the required zip /wget stuff
#
RUN apt-get update && apt-get install -y zip wget && apt-get clean;

#
# zip file to download from
# Note, You can add user/pass by doing :
# "https://user:pass@github.com/picoded/dockerfiles/archive/master.zip"
#
ENV ZIP_URL "https://github.com/picoded/dockerfiles/archive/master.zip"

# Branch or commit hash to checkout from
ENV ZIP_FILE "master.zip"

# This is the run script, called before git clone/pull
ENV ZIP_PRESCRIPT ""

# This is the run script, called after git clone/pull
ENV ZIP_POSTSCRIPT ""

#
# Prepares the git cloner script
#
RUN echo '#!/bin/bash'                                                               > /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo 'echo "### Start of picoded/zip-cloner : entrypoint/zip-cloner.sh"'          >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Enters the /workspace'                                                    >> /entrypoint/zip-cloner.sh && \
	echo 'cd /workspace;'                                                             >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'if [ -n "$ZIP_PRESCRIPT" ]; then '                                          >> /entrypoint/zip-cloner.sh && \
	echo '	echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '	echo "### prescript of picoded/zip-cloner"'                              >> /entrypoint/zip-cloner.sh && \
	echo '	echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '   eval "$ZIP_PRESCRIPT";'                                                  >> /entrypoint/zip-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Enters the /workspace'                                                    >> /entrypoint/zip-cloner.sh && \
	echo 'cd /workspace;'                                                             >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Ensures the old file is removed'                                          >> /entrypoint/zip-cloner.sh && \
	echo 'rm -f "/tmp/$ZIP_FILE";'                                                    >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Redownload the file'                                                      >> /entrypoint/zip-cloner.sh && \
	echo 'wget -O "/tmp/$ZIP_FILE" "$ZIP_URL";'                                       >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo 'echo "### Unzipping of the file package"'                                   >> /entrypoint/zip-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo '# Unzip the file contents'                                                  >> /entrypoint/zip-cloner.sh && \
	echo 'unzip -o "/tmp/$ZIP_FILE" -d "/workspace/$ZIP_FOLDER/";'                    >> /entrypoint/zip-cloner.sh && \
	echo ''                                                                           >> /entrypoint/zip-cloner.sh && \
	echo 'if [ -n "$ZIP_POSTSCRIPT" ]; then '                                         >> /entrypoint/zip-cloner.sh && \
	echo '	echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
	echo '	echo "### postscript of picoded/zip-cloner"'                             >> /entrypoint/zip-cloner.sh && \
	echo '	echo "###"'                                                              >> /entrypoint/zip-cloner.sh && \
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
ENTRYPOINT ["/entrypoint/primer.sh", "/entrypoint/zip-cloner.sh"] 
CMD echo "hello world : run your actual command here"
