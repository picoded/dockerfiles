# ubuntu-oracle-8-jdk
#
# VERSION               0.0.1
#
# Extends ubuntu-base with java 8 oracle jdk installation
#
FROM picoded/ubuntu-base
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Enable the usage of add-apt-repository
RUN \
	apt-get update && \
	apt-get install -y software-properties-common python-software-properties && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer && \
	apt-get install -y ant && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;
	
# Fix certificate issues, found as of 
# https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302
RUN apt-get update && \
	apt-get install -y ca-certificates-java && \
	apt-get clean && \
	update-ca-certificates -f && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/
RUN export JAVA_HOME
