# jenkins-slave
#
# VERSION               0.0.2
#
# Reference: https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds
# -> Important note, this is missing the -secret parameter info
#
# Note this install openjdk-8-jdk, and git-core and setsup the image as a "jenkins-slave"
#
FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Setsup the jenkins host path
ENV JENKINS_HOST https://builds.apache.org

# Setsup the jenkins slave name
ENV JENKINS_SLAVE_NAME docker-slave

# Setsup the jenkins secret password
ENV JENKINS_SLAVE_SECRET replace_this_with_jenkins_secret_key

# install git-core
RUN apt-get install -y git-core

# Copy over the slave script
COPY run-slave.sh ./

# Download the slave jar
ADD $JENKINS_HOST/jnlpJars/slave.jar ./

# And start up the slave
CMD ["./run-slave.sh"]