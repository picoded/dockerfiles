# jenkins-slave
#
# VERSION               0.0.5
#
# Reference: https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds
# -> Important note, this is missing the -secret parameter info
#
# Note this install openjdk-8-jdk, and git-core and setsup the image as a "jenkins-slave"
#
FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <eugene@picoded.com>

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
# ENV JENKINS_PRESCRIPT 
#
# Alternative proxy connection?
# ENV JENKINS_CONNECTION 
#-------------------------------------------------------

# install git-core
RUN apt-get update && \
	apt-get install -y git unzip zip wget curl && \
	apt-get clean;

#
# Downloads the slave jar, chmod it
# Then check tunnel / etc configuration
# And finally run the slave jar. Yes master!
#
RUN echo "#!/bin/bash"                                                      > /entrypoint/jenkins-run.sh && \
	echo ''                                                                  >> /entrypoint/jenkins-run.sh && \
	echo '# Remove old slave jars'                                           >> /entrypoint/jenkins-run.sh && \
	echo 'rm -f slave.jar; 2> /dev/null;'                                    >> /entrypoint/jenkins-run.sh && \
	echo 'rm -f slave.jar.*; 2> /dev/null;'                                  >> /entrypoint/jenkins-run.sh && \
	echo ''                                                                  >> /entrypoint/jenkins-run.sh && \
	echo '# Redownload new jars'                                             >> /entrypoint/jenkins-run.sh && \
	echo 'wget --no-check-certificate "$JENKINS_HOST/jnlpJars/slave.jar";'   >> /entrypoint/jenkins-run.sh && \
	echo 'chmod +x slave.jar;'                                               >> /entrypoint/jenkins-run.sh && \
	echo ''                                                                  >> /entrypoint/jenkins-run.sh && \
	echo '# Custom JENKINS_CONNECTION settings'                              >> /entrypoint/jenkins-run.sh && \
	echo 'if [[ ! -z "$JENKINS_CONNECTION" ]]; then'                         >> /entrypoint/jenkins-run.sh && \
	echo '   CONN="-connectTo $JENKINS_CONNECTION"'                          >> /entrypoint/jenkins-run.sh && \
	echo 'fi'                                                                >> /entrypoint/jenkins-run.sh && \
	echo '# Jenkins prescript execution'                                     >> /entrypoint/jenkins-run.sh && \
	echo 'if [[ ! -z "$JENKINS_PRESCRIPT" ]]; then'                          >> /entrypoint/jenkins-run.sh && \
	echo '   eval "$JENKINS_PRESCRIPT";'                                     >> /entrypoint/jenkins-run.sh && \
	echo 'fi'                                                                >> /entrypoint/jenkins-run.sh && \
	echo ''                                                                  >> /entrypoint/jenkins-run.sh && \
	echo 'java $JAVA_OPTS -jar slave.jar $JENKINS_OPTS $CONN -jnlpUrl $JENKINS_HOST/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp -secret $JENKINS_SLAVE_SECRET "$@";' >> /entrypoint/jenkins-run.sh && \
	chmod +x /entrypoint/jenkins-run.sh;

# And start up the slave
ENTRYPOINT ["/entrypoint/primer.sh", "/entrypoint/jenkins-run.sh"]
