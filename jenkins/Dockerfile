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
RUN apt-get update && apt-get install -y build-essential ant zip python doxygen curl vim

# Drop by user rights back down to jenkins
USER jenkins 
