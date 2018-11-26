# jenkins-build-slave
#
# VERSION               0.0.3
#
# This extends jenkins-slave by installing the following
# build-essential, openjdk-8-jdk, php5, python, ant. 
#
# This is setup to function as a "build-slave", for most common stuff
#
FROM picoded/jenkins-slave
MAINTAINER Eugene Cheah <eugene@picoded.com>

#
# install the following
# - build essentials
# - php5-cli with mcrypt
# - python
# - ant
# - git unzip zip
# - doxygen
# - curl
# - vim (useful for direct access debugging)
#
RUN apt-get update && apt-get install -y build-essential php7.0-cli php7.0-mcrypt python ant git unzip zip doxygen curl vim

# Updates SSH negotiation algorithms 
# 
# http://stackoverflow.com/questions/26424621/algorithm-negotiation-fail-ssh-in-jenkins
#
# RUN echo "KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1" >> /etc/ssh/ssh_config;

# install apache webhost stack
# RUN apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt

# And start up the slave
# CMD ["./setup-and-run.sh"]