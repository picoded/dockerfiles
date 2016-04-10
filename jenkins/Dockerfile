# jenkins (master)
#
# VERSION               0.0.1
#
# Reference: https://hub.docker.com/_/jenkins/
#
FROM jenkins:2.0-beta-1
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Do the various needed installation
USER root
RUN apt-get update && apt-get install -y build-essential ant zip python doxygen curl

# Drop by user rights back down to jenkins
USER jenkins 
