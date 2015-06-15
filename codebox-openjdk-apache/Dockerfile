# codebox-openjdk-apache
#
# VERSION               0.0.1
#
# Setsup and configure a codebox, with openjdk8 and apache installed
#
# See: https://github.com/CodeboxIDE/codebox
#
FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# install git and coding core utils
RUN apt-get update && apt-get install -y git unzip zip

# install build essentials
RUN apt-get install -y build-essential 

# install common command line utilities
RUN apt-get install -y php5-cli php5-mcrypt python ant doxygen

# install nodejs
RUN apt-get install -y nodejs npm

# install apache webhost stack
RUN apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-cli

# Installing node-js legacy, needed by codebox, for now
RUN apt-get install nodejs-legacy

# Install codebox from npm
RUN npm install --yes --global codebox

# move the default /var/www contents to /workspace/www
RUN mkdir /workspace && mkdir /workspace/www && mv /var/www/html/index.html /workspace/www/ 

# and relinks /var/www/html to /workspace/www
RUN rmdir /var/www/html && ln -s /workspace/www /var/www && cd /var/www && mv www html 

# Volume links
VOLUME ["/workspace", "/var/log/apache2", "/etc/apache2"]

# expose port 80, 443 for apache, 8000 for code box, 8080 for tomcat (if added)
EXPOSE 80 443 8000 8080

# Setsup the codebox userpass list
ENV CODEBOX_USERPASS codebox@picoded.com:password,codebox2@picoded.com:password

# And start up apache and the codebox server
CMD service apache2 start && codebox run /workspace -u "$CODEBOX_USERPASS"