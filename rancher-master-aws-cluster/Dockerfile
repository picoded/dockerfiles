# rancher-master-aws-cluster
#
# VERSION               0.0.1
#
# until the following get pushed to stable : https://github.com/rancher/rancher/pull/7250
# this is a temporary fix.
#
FROM rancher/server:stable
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Runs the entry point with the AWS command
ENTRYPOINT /usr/bin/entry --advertise-address $(curl -s 169.254.169.254/latest/meta-data/local-ipv4) 