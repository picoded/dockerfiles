# ubuntu-openjdk-8-jdk
#
# VERSION               0.0.3
#
# Extends ubuntu-base with java 8 openjdk jdk installation
#
FROM picoded/ubuntu-base
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Install the python script required for "add-apt-repository"
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get clean;
	
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f;

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
