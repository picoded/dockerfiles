#
# rancher-cli
#
# VERSION               0.0.1
#
FROM picoded/ubuntu-base
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Get the required git and docker
RUN apt-get update && apt-get install -y git docker-ce && apt-get clean;

# Clone the ranchers tools
RUN cd /etc && git clone https://github.com/picoded/rancher-container-backup-via-cli.git && mv rancher-container-backup-via-cli rancher-cli

# Environment variables for rancher
ENV RANCHER_URL "";
ENV RANCHER_ACCESS_KEY "";
ENV RANCHER_SECRET_KEY "";

# After configuring those ENV variables
# if you want to run a rancher command
# use the following
#
# /etc/rancher-cli/rancher.sh [rancher commands]