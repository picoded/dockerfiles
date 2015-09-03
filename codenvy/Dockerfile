# codenvy docker
#
# VERSION               0.0.1
#
FROM centos:7
MAINTAINER Eugene Cheah <eugene@picoded.com>

# Update the OS
RUN yum -y update && yum clean all

# Install curl
RUN yum -y install wget

# Install SUDO
RUN yum -y install sudo
#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Disable TTY (cause it breaks the installation process)
RUN sed -i 's/Defaults    requiretty/# Defaults    requiretty/g' /etc/sudoers
# RUN cat /etc/sudoers

# Environment variable, used to setup root password (instead of having a fixed one)
ENV HOST_NAME onprem.codenvy.com
ENV ADMIN_NAME admin
ENV ADMIN_PASS password

# Override dumb terminal setting
ENV TERM xterm

# Workdir
WORKDIR ~

# Download install script
RUN wget https://start.codenvy.com/install-codenvy

# Run the installlation
RUN sudo bash ./install-codenvy --hostname $HOST_NAME --silent --systemAdminName=$ADMIN_NAME --systemAdminPassword=$ADMIN_PASS

