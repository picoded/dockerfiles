# codebox-tomcat-apache
#
# VERSION               0.0.1
#
# Setsup and configure a codebox, with openjdk8 and apache installed
#
# See: https://github.com/CodeboxIDE/codebox
#
FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <eugene@picoded.com>

# install git and coding core utils
RUN apt-get update && apt-get install -y git unzip zip build-essential 

# install common command line utilities
RUN apt-get update && apt-get install -y php5-cli php5-mcrypt python ant doxygen wget 

# install apache webhost stack
RUN apt-get update && apt-get install -y apache2 php5 libapache2-mod-php5 php5-mcrypt php5-cli php5-curl

# install nodejs stack
RUN apt-get update && apt-get install -y nodejs npm nodejs-legacy

# Install codebox from npm
RUN npm install --yes --global codebox

# Volume links mount for workspace
RUN mkdir /workspace
VOLUME ["/workspace"]

# move the default /var/www contents to /workspace/www
RUN mkdir /workspace/www && mv /var/www/html/index.html /workspace/www/ 

# and relinks /var/www/html to /workspace/www
RUN rmdir /var/www/html && ln -s /workspace/www /var/www && cd /var/www && mv www html 

# Setup the workspace
WORKDIR /workspace;

# download tomcat 8, and uncompress it
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz;
RUN tar xvf apache-tomcat-8*tar.gz && rm apache-tomcat-8*.tar.gz;
RUN mv apache-tomcat-8* tomcat8;

# expose port 80, 443 for apache, 8000 for code box, 8080 for tomcat (if added)
EXPOSE 80 443 8000 8080

# Setsup the codebox userpass list
ENV CODEBOX_USERPASS codebox@picoded.com:password,codebox2@picoded.com:password

# And start up apache and the codebox server
CMD service apache2 start && codebox run /workspace -u "$CODEBOX_USERPASS"