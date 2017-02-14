# clones a git repo,
# do whatever you want with it after cloning
#
# VERSION               1.0.1
#
FROM picoded/ubuntu-base

#
# Get the required git stuff
#
RUN apt-get update && apt-get install -y git && apt-get clean;

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

# This is the run script, called before git clone/pull
ENV GIT_PRESCRIPT ""

# This is the run script, called after git clone/pull
ENV GIT_POSTSCRIPT ""

#
# Prepares the git cloner script
#
RUN echo '#!/bin/bash'                                                               > /entrypoint/git-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/git-cloner.sh && \
	echo 'echo "### Start of picoded/git-cloner : entrypoint/git-cloner.sh"'          >> /entrypoint/git-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo '# Enters the /workspace'                                                    >> /entrypoint/git-cloner.sh && \
	echo 'cd /workspace;'                                                             >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo 'if [ -n "$GIT_PRESCRIPT" ]; then '                                          >> /entrypoint/git-cloner.sh && \
	echo '   eval "$GIT_PRESCRIPT";'                                                  >> /entrypoint/git-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo '# Ensures the git repo is cloned'                                           >> /entrypoint/git-cloner.sh && \
	echo 'if [ ! -d "$GIT_FOLDER/.git" ]; then '                                      >> /entrypoint/git-cloner.sh && \
	echo '   git clone --recursive "$GIT_REPO" "$GIT_FOLDER";'                        >> /entrypoint/git-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo '# Enter git repo and pull updates (if needed)'                              >> /entrypoint/git-cloner.sh && \
	echo 'cd "$GIT_FOLDER"'                                                           >> /entrypoint/git-cloner.sh && \
	echo 'git fetch;'                                                                 >> /entrypoint/git-cloner.sh && \
	echo 'git checkout "$GIT_COMMIT";'                                                >> /entrypoint/git-cloner.sh && \
	echo 'git pull;'                                                                  >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo 'if [ -n "$GIT_POSTSCRIPT" ]; then '                                         >> /entrypoint/git-cloner.sh && \
	echo '   eval "$GIT_POSTSCRIPT";'                                                 >> /entrypoint/git-cloner.sh && \
	echo 'fi '                                                                        >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/git-cloner.sh && \
	echo 'echo "### Finished picoded/git-cloner : entrypoint/git-cloner.sh"'          >> /entrypoint/git-cloner.sh && \
	echo 'echo "###"'                                                                 >> /entrypoint/git-cloner.sh && \
	echo ''                                                                           >> /entrypoint/git-cloner.sh && \
	echo 'cd "/workspace/$GIT_FOLDER/"'                                               >> /entrypoint/git-cloner.sh && \
	echo 'exec "$@"'                                                                  >> /entrypoint/git-cloner.sh && \
	chmod +x /entrypoint/git-cloner.sh;
	
#
# Useful for build debugging
#
# RUN cat /entrypoint/git-cloner.sh;

#
# Runs with entry point and command
#
ENTRYPOINT ["/entrypoint/primer.sh", "/entrypoint/git-cloner.sh"] 
CMD echo "hello world : run your actual command here"
