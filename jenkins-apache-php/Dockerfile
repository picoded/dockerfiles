# jenkins-apache-php
#
# VERSION               0.0.1
#
# This extends jenkins-slave by installing the following
# build-essential, openjdk-8-jdk, php5, python, ant. 
#
# This is setup to function as a "build-slave", for most common stuff
#
FROM picoded/jenkins-slave
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# run update
RUN apt-get update

# install python
RUN apt-get install -y python

# install apache webhost stack
RUN apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-cli

# expose port 80
EXPOSE 80 443

# Start apache
RUN /usr/sbin/apache2ctl -k start

# And start up the slave
CMD ["./run-slave.sh"]