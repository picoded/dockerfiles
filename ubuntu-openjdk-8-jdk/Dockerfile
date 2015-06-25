# ubuntu-openjdk-8-jdk
#
# VERSION               0.0.2
#
# Reference: http://ubuntuhandbook.org/index.php/2015/01/install-openjdk-8-ubuntu-14-04-12-04-lts/
# -> Important note, this is missing the -secret parameter info
#
# This takes ubuntu 14.04 LTS, and forces openjdk-8-jdk to be installed via backports. 
# Where future docker images can extend from (eg. jenkins-slave)
#
# Also sets language to en_US.UTF-8 by default
#
FROM ubuntu:14.04
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Setup the openjdk 8 repo
RUN add-apt-repository ppa:openjdk-r/ppa

# Install java8
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Setup JAVA_HOME, this is useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
export JAVA_HOME

# Show java version (for debugging)
# RUN java -version