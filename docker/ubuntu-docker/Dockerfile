# ubuntu-docker
#
# VERSION               0.0.1
#
# Extends ubuntu-base with docker installation
#
FROM picoded/ubuntu-base
MAINTAINER Eugene Cheah <eugene@picoded.com>

#
# Install depencies required for docker-ce
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository
#
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*;

#
# Installing docker-ce itself
#
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
RUN apt-get update && \
	apt-get install -y docker-ce && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*;