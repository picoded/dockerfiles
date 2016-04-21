# jenkins (master)
#
# VERSION               0.0.1
#
# Reference: https://hub.docker.com/_/jenkins/
#
FROM jenkins:latest
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Do the various needed installation
USER root
RUN apt-get update && apt-get install -y build-essential ant zip python doxygen curl vim git unzip zip

# Updates SSH negotiation algorithms 
# 
# http://stackoverflow.com/questions/26424621/algorithm-negotiation-fail-ssh-in-jenkins
#
RUN echo "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1" >> /etc/ssh/ssh_config;

# Drop by user rights back down to jenkins
USER jenkins 
