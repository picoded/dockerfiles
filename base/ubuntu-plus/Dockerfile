# ubuntu-plus
#
# VERSION               0.0.3
#
# Extends ubuntu-base with java 8 openjdk jdk installation, and NPM
#
FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <eugene@picoded.com>

# This is in accordance to : https://nodejs.org/en/download/package-manager/
RUN apt-get update && apt-get install -y nodejs && apt-get clean;
