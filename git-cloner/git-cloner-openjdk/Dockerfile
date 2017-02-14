# clones a git repo,
# do whatever you want with it with a script
#
# Now with OpenJDK 8
#
# VERSION               1.0.1
#
FROM picoded/git-cloner-base:latest

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean;
