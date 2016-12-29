# clones a git repo,
# do whatever you want with it with a script
#
# Now with every single varient of git-cloner-plus
#
# VERSION               1.0.1
#
FROM picoded/git-cloner-base:latest

# This is in accordance to : https://nodejs.org/en/download/package-manager/
# https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update; \
	apt-get install -y default-jdk && \
	apt-get install -y ant && \
	apt-get install -y npm && \
	apt-get install -y nodejs;
