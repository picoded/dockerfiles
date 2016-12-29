# clones a git repo,
# do whatever you want with it with a script
#
# Now with NPM !
#
# VERSION               0.0.1
#
FROM picoded/git-cloner:latest

# This is in accordance to : https://nodejs.org/en/download/package-manager/
RUN apt-get update; \
	apt-get install -y sudo curl build-essential; \
	curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -; \
	sudo apt-get update; \
	sudo apt-get install -y nodejs;
