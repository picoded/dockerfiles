# ubuntu-openjdk-8-jdk
#
# VERSION               0.0.2
#
# Reference: https://docs.docker.com/installation/ubuntulinux/
#
# This takes ubuntu 14.04 LTS, and install docker with it. Docker inside docker!
#
# Also sets language to en_US.UTF-8 by default
#
FROM ubuntu:14.04
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Install curl
RUN apt-get install -y curl

# Install docker
RUN curl -sSL https://get.docker.com/ | sh

# Test run
RUN docker run hello-world
