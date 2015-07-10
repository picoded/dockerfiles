# ubuntu-nodejs
#
# VERSION               0.0.1
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

# Install the python repo (2.7 ?)
RUN apt-get update && apt-get install git nodejs npm -y

