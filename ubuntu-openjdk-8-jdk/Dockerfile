# ubuntu-openjdk-8-jdk
#
# VERSION               0.0.1
#
# Reference: http://ubuntuhandbook.org/index.php/2015/01/install-openjdk-8-ubuntu-14-04-12-04-lts/
# -> Important note, this is missing the -secret parameter info
#
# This takes ubuntu 14.04 LTS, and forces openjdk-8-jdk to be installed. 
# Where future docker images can extend from
#
FROM ubuntu:14.04
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common

# Setup the openjdk 8 repo
RUN add-apt-repository ppa:openjdk-r/ppa

# Install java8
RUN apt-get update && apt-get install -y openjdk-8-jdk

# Show java version (for debugging)
# RUN java -version