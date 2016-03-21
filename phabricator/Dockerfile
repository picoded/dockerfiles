# phabricator
#
# VERSION               0.0.1
#
# Note this is referenced from 
# - https://hub.docker.com/_/php/
# - https://secure.phabricator.com/book/phabricator/article/installation_guide/
#
FROM php:7-apache
MAINTAINER Eugene Cheah <eugene@picoded.com>

# install common package utility and dependencies
RUN apt-get update && apt-get install -y git unzip zip libmcrypt-dev libssl-dev libcurl4-openssl-dev ftp libpng-dev

# Install pdo_mysql
RUN docker-php-ext-install mysqli pdo_mysql

# Install phabricator dependencies
RUN docker-php-ext-install curl sockets mbstring mcrypt zip iconv curl pcntl gd
RUN docker-php-ext-install ftp opcache json

# Note that since opcache comes preinstalled in php7
# APC is not installed (nor is there a way to do so in docker build)

# Install apache mod rewrite
RUN a2enmod rewrite

# List possible modules to be installed
# RUN docker-php-ext-install

RUN mkdir /phabricator && \
	cd /phabricator && \
	git clone https://github.com/phacility/libphutil.git && \
	git clone https://github.com/phacility/arcanist.git && \
	git clone https://github.com/phacility/phabricator.git

# Overwrite document root
RUN cd /etc/apache2/ && \
	sed -i 's|DocumentRoot /var/www/html|DocumentRoot /phabricator/phabricator/webroot|' apache2.conf && \
	echo "" >> apache2.conf && \
	echo '<Directory "/phabricator/phabricator/webroot">' >> apache2.conf && \
	echo 'Order allow,deny' >> apache2.conf && \
	echo 'Allow from all' >> apache2.conf && \
	echo '</Directory>' >> apache2.conf

#RUN ls /etc/apache2/
#RUN cat /etc/apache2/apache2.conf
#WORKDIR /phabricator


RUN cd /phabricator/phabricator && ls conf/local

# expose port 80
EXPOSE 80 443

# And start up the slave
ENTRYPOINT apache2-foreground
CMD apache2-foreground