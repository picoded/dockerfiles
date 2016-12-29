# clones a git repo,
# do whatever you want with it with a script
#
# VERSION               0.0.1
#
FROM ubuntu:16.04

# Make sure the sshd folder exists
RUN mkdir /workspace
WORKDIR /workspace

#
# Get the required git stuff
#
RUN apt-get update && apt-get install -y git;

#
# Git repo to clone from
# Note, You can add user/pass by doing :
# "https://user:pass@github.com/picoded/dockerfiles.git"
#
ENV GIT_REPO "https://github.com/picoded/dockerfiles.git"

# Branch or commit hash to take from
ENV GIT_COMMIT "master"

# The folder name to clone into
ENV WORKSPACE_FOLDER "repo"

# This is the run script, called before git clone/pull
ENV PRE_SCRIPT ""

#
# Prepares the git runner script
#
RUN echo '#!/bin/bash' > /git-cloner.sh && \
	echo '' >> /git-cloner.sh && \
	echo '# Enters the /workspace' >> /git-cloner.sh && \
	echo 'cd /workspace;' >> /git-cloner.sh && \
	echo '' >> /git-cloner.sh && \
	echo 'if [ -n "$PRE_SCRIPT" ]; then ' >> /git-cloner.sh && \
	echo '	eval "$PRE_SCRIPT";' >> /git-cloner.sh && \
	echo 'fi ' >> /git-cloner.sh && \
	echo '' >> /git-cloner.sh && \
	echo '# Ensures the git repo is cloned' >> /git-cloner.sh && \
	echo 'if [ ! -d "$WORKSPACE_FOLDER" ]; then ' >> /git-cloner.sh && \
	echo '	mkdir -pf "$WORKSPACE_FOLDER";' >> /git-cloner.sh && \
	echo '	git clone "$GIT_REPO" "$WORKSPACE_FOLDER";' >> /git-cloner.sh && \
	echo 'fi ' >> /git-cloner.sh && \
	echo '' >> /git-cloner.sh && \
	echo '# Enter git repo and pull updates (if needed)' >> /git-cloner.sh && \
	echo 'cd "$WORKSPACE_FOLDER"' >> /git-cloner.sh && \
	echo 'git fetch;' >> /git-cloner.sh && \
	echo 'git checkout "$GIT_COMMIT";' >> /git-cloner.sh && \
	echo 'git pull;' >> /git-cloner.sh && \
	echo '' >> /git-cloner.sh && \
	echo 'echo ">> git clone / pull completed"' >> /git-cloner.sh && \
	echo 'cd "/workspace/$WORKSPACE_FOLDER"' >> /git-cloner.sh && \
	echo 'exec "$@"' >> /git-cloner.sh && \
	chmod +x /git-cloner.sh && chmod -R 0777 /workspace && chmod +x /workspace;
	
#
# Useful for build debugging
#
RUN cat /git-cloner.sh;

#
# Runs with entry point and command
#
ENTRYPOINT ["/git-cloner.sh"] 
CMD echo "hello world : run your actual command here"
