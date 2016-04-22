# php7-ssh
#
# Reorganised to fit our standard /workspace model
#
# VERSION               0.0.2
#
# Note this is referenced from : https://hub.docker.com/_/php/
#
FROM picoded/php7
MAINTAINER Eugene Cheah <eugene@picoded.com>

# install common package utility
RUN apt-get update && apt-get install -y openssh-server

# Reconfigure the SSH to accept login as root, with the specified password
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config 

# 
# Fix an SSH login issue : i do not know why
# http://unix.stackexchange.com/questions/148714/cant-ssh-connection-terminates-immediately-with-exit-status-254
#
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# Updates SSH negotiation algorithms 
# 
# http://stackoverflow.com/questions/26424621/algorithm-negotiation-fail-ssh-in-jenkins
#
RUN echo "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1" >> /etc/ssh/ssh_config;

# Expose port 22 (SSH)
EXPOSE 22

# Environment variable, used to setup root password (instead of having a fixed one)
ENV SSH_ROOT_PASS password_pls_change

# And start up the slave
ENTRYPOINT echo "root:$SSH_ROOT_PASS" | chpasswd && service ssh start && apache2-foreground
CMD echo "root:$SSH_ROOT_PASS" | chpasswd && service ssh start && apache2-foreground