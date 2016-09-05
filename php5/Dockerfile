# php5
#
# Reorganised to fit our standard /workspace model
#
# VERSION               0.0.2
#
# Note this is referenced from : https://hub.docker.com/_/php/
#
FROM php:5-apache
MAINTAINER Eugene Cheah <eugene@picoded.com>

# install common package utility
RUN apt-get update && apt-get install -y git unzip zip

# install dependency module
RUN apt-get install -y libmcrypt-dev libssl-dev libcurl4-openssl-dev ftp

# Install pdo_mysql
RUN docker-php-ext-install mysqli pdo_mysql
RUN docker-php-ext-install curl sockets mbstring mcrypt zip

# move the default /var/www contents to /workspace/www
RUN mkdir /workspace && mkdir /workspace/www && mv /var/www/html/index.html /workspace/www/ 

# and relinks /var/www/html to /workspace/www
RUN rmdir /var/www/html && ln -s /workspace/www /var/www && cd /var/www && mv www html 

# Volume links
VOLUME ["/workspace/www", "/var/log/apache2", "/etc/apache2"]

# expose port 80
EXPOSE 80 443
WORKDIR /workspace/www

# And start up the slave
ENTRYPOINT apache2-foreground
CMD apache2-foreground
