# jenkins (master)
#
# VERSION               0.0.1
#
# Reference: https://hub.docker.com/_/jenkins/
#
FROM jenkins/jenkins:2.160
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Do the various needed installation
USER root
RUN apt-get update && \
	apt-get install -y build-essential ant zip python doxygen curl vim git unzip zip && \
	apt-get clean;

# Ports to expose
# (already done in jeknins base repo)
EXPOSE 8080 50000

# Additionally you have access to the environment variable
ENV JAVA_OPTS="-Duser.timezone=Asia/Singapore"

# JENKINS_HOME volume mount point
VOLUME ["/var/jenkins_home"]

# Drop by user rights back down to jenkins
USER jenkins 
