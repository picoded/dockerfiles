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

#-------------------------------------------------------
# Critical Configurations 
#-------------------------------------------------------
# Setsup the jenkins host path
ENV JENKINS_HOST https://builds.apache.org

# Setsup the jenkins slave name
ENV JENKINS_SLAVE_NAME docker-slave

# Setsup the jenkins slave password
ENV JENKINS_SLAVE_SECRET super-not-so-secure-token

#-------------------------------------------------------
# Blank configurations (by default)
#-------------------------------------------------------
# Additional java options
# ENV JAVA_OPTS 
#
# Additional jenkins options
# ENV JENKINS_OPTS 
#
# Additional jenkins options
# ENV PRE_SCRIPT 
#
# Alternative proxy connection?
# ENV JENKINS_CONNECTION 
#-------------------------------------------------------

# install git-core
RUN apt-get update && apt-get install -y git unzip zip wget curl

#
# Downloads the slave jar, chmod it
# Then check tunnel / etc configuration
# And finally run the slave jar. Yes master!
#
RUN echo "#!/bin/bash" > setup-and-run.sh && \
	echo 'rm -f slave.jar; 2> /dev/null;' && \
	echo 'rm -f slave.jar.*; 2> /dev/null;' && \
	echo 'wget --no-check-certificate "$JENKINS_HOST/jnlpJars/slave.jar";' >> setup-and-run.sh && \
	echo 'chmod +x slave.jar;' >> setup-and-run.sh && \
	echo 'if [[ ! -z "$JENKINS_CONNECTION" ]]; then' >> setup-and-run.sh && \
	echo '		CONN="-connectTo $JENKINS_CONNECTION"' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	echo 'if [[ ! -z "$PRE_SCRIPT" ]]; then' >> setup-and-run.sh && \
	echo '		eval $PRE_SCRIPT;' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	echo 'java $JAVA_OPTS -jar slave.jar $JENKINS_OPTS $CONN -jnlpUrl $JENKINS_HOST/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp -secret $JENKINS_SLAVE_SECRET;' >> setup-and-run.sh && \
	chmod +x setup-and-run.sh

# And start up the slave
CMD ["./setup-and-run.sh"]
