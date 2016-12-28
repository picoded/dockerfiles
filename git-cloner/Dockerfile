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

# Git repo to clone from
ENV GIT_REPO "https://github.com/octocat/Hello-World.git"

# Branch or commit hash to take from
ENV GIT_COMMIT "master"

# The folder name to clone into
ENV WORKSPACE_FOLDER "repo"

# This is the run script, called before git clone/pull
ENV PRE_SCRIPT ""

#
# Prepares the git runner script
#
RUN echo '#!/bin/bash' > /git-clone.sh && \
	echo '' >> /git-clone.sh && \
	echo '# Enters the /workspace' >> /git-clone.sh && \
	echo 'cd /workspace;' >> /git-clone.sh && \
	echo '' >> /git-clone.sh && \
	echo 'if [ -n "$PRE_SCRIPT" ]; then ' >> /git-clone.sh && \
	echo '	eval "$PRE_SCRIPT";' >> /git-clone.sh && \
	echo 'fi ' >> /git-clone.sh && \
	echo '' >> /git-clone.sh && \
	echo '# Ensures the git repo is cloned' >> /git-clone.sh && \
	echo 'if [ ! -d "$WORKSPACE_FOLDER" ]; then ' >> /git-clone.sh && \
	echo '	mkdir -pf "$WORKSPACE_FOLDER";' >> /git-clone.sh && \
	echo '	git clone "$GIT_REPO" "$WORKSPACE_FOLDER";' >> /git-clone.sh && \
	echo 'fi ' >> /git-clone.sh && \
	echo '' >> /git-clone.sh && \
	echo '# Enter git repo and pull updates (if needed)' >> /git-clone.sh && \
	echo 'cd "$WORKSPACE_FOLDER"' >> /git-clone.sh && \
	echo 'git fetch;' >> /git-clone.sh && \
	echo 'git checkout "$GIT_COMMIT";' >> /git-clone.sh && \
	echo 'git pull;' >> /git-clone.sh && \
	echo '' >> /git-clone.sh && \
	chmod +x /git-clone.sh && chmod -R 0777 /workspace && chmod +x /workspace;
	
#
# Useful for build debugging
# RUN cat /git-clone.sh;
#

#
# Runs with entry point and command
#
ENTRYPOINT ["/git-clone.sh", "&&", "bash"]; 
CMD [ "echo", ">> pull/clone completed" ];
