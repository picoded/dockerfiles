# jenkins-build-slave
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

# install build essentials
RUN apt-get update && apt-get install -y build-essential zip

# install php5-cli
RUN apt-get install -y php5-cli php5-mcrypt

# install python
RUN apt-get install -y python

# install apache ant
RUN apt-get install -y ant

# install doxygen
RUN apt-get install -y doxygen

# install apache webhost stack
# RUN apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt

# And start up the slave
CMD ["./run-slave.sh"]