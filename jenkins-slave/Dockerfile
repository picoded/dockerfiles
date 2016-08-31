# jenkins-slave
#
# VERSION               0.0.4
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
RUN apt-get update && apt-get install -y git unzip zip wget curl

# Copy over the slave script
# COPY run-slave.sh ./

# Download the slave jar
# ADD $JENKINS_HOST/jnlpJars/slave.jar ./

RUN echo "#!/bin/bash" > setup-and-run.sh && \
	echo 'rm -f slave.jar 2> /dev/null;' && \
	echo 'wget --no-check-certificate "$JENKINS_HOST/jnlpJars/slave.jar";' >> setup-and-run.sh && \
	echo 'chmod +x slave.jar;' >> setup-and-run.sh && \
	echo 'java -jar slave.jar -jnlpUrl $JENKINS_HOST/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp -secret $JENKINS_SLAVE_SECRET;' >> setup-and-run.sh && \
	chmod +x setup-and-run.sh

# And start up the slave
CMD ["./setup-and-run.sh"]