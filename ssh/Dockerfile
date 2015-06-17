# ssh
#
# VERSION               0.0.2
#
# Note this is referenced from : https://docs.docker.com/examples/running_ssh_service/
#
FROM ubuntu:14.04
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Install the open ssh server
RUN apt-get update && apt-get install -y openssh-server

# Make sure the sshd folder exists
RUN mkdir /var/run/sshd

# Environment variable, used to setup root password (instead of having a fixed one)
ENV SSH_ROOT_PASS password_pls_change

# Setup the password for root
RUN echo "root:$SSH_ROOT_PASS" | chpasswd

# Reconfigure the SSH to accept login as root, with the specified password
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# Defining variables in /etc/profile
# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# Expose port 22 (SSH)
EXPOSE 22

# Run sshd, on build in the background, this is used for downstream images
# ONBUILD RUN /usr/sbin/sshd

# This image "command"
CMD ["/usr/sbin/sshd", "-D"]