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
#
# @TODO remove the "require all granted" global overwrite : I do not know why the Directory ruling is not working
#
#	echo '	AllowOverride All' >> apache2.conf && \
#	sed -i 's|DocumentRoot /var/www/html|DocumentRoot /phabricator/phabricator/webroot|' apache2.conf && \
#	sed -i 's|Require all denied|Require all granted|' apache2.conf && \
#
RUN cd /etc/apache2/ && \
	echo '' > sites-available/000-default.conf && \
	echo '' > sites-available/default-ssl.conf && \
	echo '' >> apache2.conf && \
	echo '<VirtualHost *>' >> apache2.conf && \
	echo '	<Directory "/phabricator/phabricator/webroot/">' >> apache2.conf && \
	echo '		Options All Indexes FollowSymLinks' >> apache2.conf && \
	echo '		Order allow,deny' >> apache2.conf && \
	echo '		Allow from all' >> apache2.conf && \
	echo '		Require all granted' >> apache2.conf && \
	echo '	</Directory>' >> apache2.conf && \
	echo '' >> apache2.conf && \
	echo '	ServerName localhost' >> apache2.conf && \
	echo '	DocumentRoot /phabricator/phabricator/webroot' >> apache2.conf && \
	echo '	DirectoryIndex index.php' >> apache2.conf && \
	echo '	RewriteEngine on' >> apache2.conf && \
	echo '	RewriteRule ^/rsrc/(.*)     -                       [L,QSA]  ' >> apache2.conf && \
	echo '	RewriteRule ^/favicon.ico   -                       [L,QSA]  ' >> apache2.conf && \
	echo '	RewriteRule ^(.*)$          /index.php?__path__=$1  [B,L,QSA]' >> apache2.conf && \
	echo '</VirtualHost>' >> apache2.conf && \
	echo '' >> apache2.conf && \
	chmod +x sites-available/000-default.conf;

#RUN ls /etc/apache2/
#RUN cat /etc/apache2/apache2.conf
#WORKDIR /phabricator
#RUN cd /phabricator/phabricator && ls conf/local

WORKDIR /phabricator

ENV MYSQL_HOST mysql_host_here
ENV MYSQL_PORT 3306
ENV MYSQL_USER phabricator
ENV MYSQL_PASS password_over_here

RUN echo "#!/bin/bash" > update-and-setup.sh && \
	echo 'INSTALL_DIR="/phabricator"' >> update-and-setup.sh && \
	echo 'cd $INSTALL_DIR/libphutil && git pull;' >> update-and-setup.sh && \
	echo 'cd $INSTALL_DIR/arcanist && git pull;' >> update-and-setup.sh && \
	echo 'cd $INSTALL_DIR/phabricator && git pull;' >> update-and-setup.sh && \
	echo 'PHAB_DIR="/phabricator/phabricator"' >> update-and-setup.sh && \
	echo '$PHAB_DIR/bin/config set mysql.host "${MYSQL_HOST}"' >> update-and-setup.sh && \
	echo '$PHAB_DIR/bin/config set mysql.port "${MYSQL_PORT}"' >> update-and-setup.sh && \
	echo '$PHAB_DIR/bin/config set mysql.user "${MYSQL_USER}"' >> update-and-setup.sh && \
	echo '$PHAB_DIR/bin/config set mysql.pass "${MYSQL_PASS}"' >> update-and-setup.sh && \
	echo '$PHAB_DIR/bin/storage upgrade --force' >> update-and-setup.sh && \
	echo '$PHAB_DIR/bin/phd start' >> update-and-setup.sh && \
	chmod +x update-and-setup.sh

# expose port 80
EXPOSE 80

# And start up the slave
ENTRYPOINT ./update-and-setup.sh && apache2-foreground
CMD ./update-and-setup.sh && apache2-foreground