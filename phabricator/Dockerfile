# phabricator
#
# VERSION               0.0.2
#
# Note this is referenced from 
# - https://hub.docker.com/_/php/
# - https://secure.phabricator.com/book/phabricator/article/installation_guide/
#
FROM php:5-apache
MAINTAINER Eugene Cheah <eugene@picoded.com>

# install common package utility and dependencies
RUN apt-get update && apt-get install -y \
	git unzip zip \
	libmcrypt-dev libssl-dev libcurl4-openssl-dev \
	ftp sendmail python-pygments \
	libpng-dev libjpeg-dev \
	libfreetype6-dev libjpeg62-turbo-dev libpng12-dev

# Install pdo_mysql
RUN docker-php-ext-install mysqli pdo_mysql

# Install phabricator dependencies
RUN docker-php-ext-install -j$(nproc) curl sockets mbstring mcrypt zip iconv curl pcntl ftp opcache json && \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
	docker-php-ext-install -j$(nproc) gd

# Note that since opcache comes preinstalled in php7
# APC is not installed (nor is there a way to do so in docker build)

# Install apache mod rewrite
RUN a2enmod rewrite

# List possible modules to be installed
# RUN docker-php-ext-install

RUN mkdir /phabricator && \
	cd /phabricator && \
	git clone -b stable https://github.com/phacility/libphutil.git && \
	git clone -b stable https://github.com/phacility/arcanist.git && \
	git clone -b stable https://github.com/phacility/phabricator.git

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
	echo '' >> apache2.conf && \
	echo '	php_value post_max_size 32M' >> apache2.conf && \
	echo '	php_value upload_max_filesize 32M' >> apache2.conf && \
	echo '	php_value opcache.validate_timestamps 0' >> apache2.conf && \
	echo '' >> apache2.conf && \
	echo '	DirectoryIndex index.php' >> apache2.conf && \
	echo '	RewriteEngine on' >> apache2.conf && \
	echo '	RewriteRule ^/rsrc/(.*)     -                       [L,QSA]  ' >> apache2.conf && \
	echo '	RewriteRule ^/favicon.ico   -                       [L,QSA]  ' >> apache2.conf && \
	echo '	RewriteRule ^(.*)$          /index.php?__path__=$1  [B,L,QSA]' >> apache2.conf && \
	echo '</VirtualHost>' >> apache2.conf && \
	echo '' >> apache2.conf && \
	chmod +x sites-available/000-default.conf;

#RUN cat /etc/apache2/apache2.conf
#RUN cd /phabricator/phabricator && ls conf/local

WORKDIR /phabricator

# Performs a phabricator upgrade on boot
# (note this can backfire, so do make due consideration on its usage)
ENV UPGRADE_ON_BOOT false

# Site base url to use
ENV BASE_URL ""

# MYSQL storage, host, port, user, passwords
ENV MYSQL_FILE_STORAGE 9000000
ENV MYSQL_HOST mysql_host_here
ENV MYSQL_PORT 3306
ENV MYSQL_USER phabricator
ENV MYSQL_PASS password_over_here

# PHP script to inject
ENV PREAMBLE_SCRIPT ""

# Additional script options
ENV PRE_SCRIPT ""

# Enables / Disable background phd thread
ENV BACKGROUND_THREAD true

RUN echo "#!/bin/bash" > setup-and-run.sh && \
	echo 'INSTALL_DIR="/phabricator"' >> setup-and-run.sh && \
	echo 'PHAB_DIR="/phabricator/phabricator";' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'echo "<?php ${PREAMBLE_SCRIPT} ?>" > $PHAB_DIR/support/preamble.php;' >> setup-and-run.sh && \
	echo 'chmod +x $PHAB_DIR/support/preamble.php;' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'if [ "$UPGRADE_ON_BOOT" = true ]; then' >> setup-and-run.sh && \
	echo '	echo "## Doing library update on bootup (UPGRADE_ON_BOOT=true)";' >> setup-and-run.sh && \
	echo '	cd $INSTALL_DIR/libphutil && git pull;' >> setup-and-run.sh && \
	echo '	cd $INSTALL_DIR/arcanist && git pull;' >> setup-and-run.sh && \
	echo '	cd $INSTALL_DIR/phabricator && git pull;' >> setup-and-run.sh && \
	echo 'else' >> setup-and-run.sh && \
	echo '	echo "## Skipping library update (UPGRADE_ON_BOOT=false)";' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'if [[ ! -z "$PRE_SCRIPT" ]]; then' >> setup-and-run.sh && \
	echo '	echo "## Running PRE_SCRIPT";' >> setup-and-run.sh && \
	echo '	eval $PRE_SCRIPT;' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'if [[ ! -z "$BASE_URL" ]];' >> setup-and-run.sh && \
	echo '	echo "## Applying base URL = ${BASE_URL}";' >> setup-and-run.sh && \
	echo '	set phabricator.base-uri "${BASE_URL}";' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'echo "## Applying MySQL configurations - ${MYSQL_HOST}";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/config set mysql.host "${MYSQL_HOST}";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/config set mysql.port "${MYSQL_PORT}";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/config set mysql.user "${MYSQL_USER}";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/config set mysql.pass "${MYSQL_PASS}";' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'echo "## Applying storage configurations";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/config set storage.mysql-engine.max-size "${MYSQL_FILE_STORAGE}";' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'echo "## Running storage upgrade";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/storage upgrade --force;' >> setup-and-run.sh && \
	echo '' >> setup-and-run.sh && \
	echo 'if [ "$BACKGROUND_THREAD" = true ]; then' >> setup-and-run.sh && \
	echo '	echo "## Starting background thread";' >> setup-and-run.sh && \
	echo '	$PHAB_DIR/bin/phd start;' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	chmod +x setup-and-run.sh
# echo '$PHAB_DIR/bin/storage upgrade --force ---host "${MYSQL_HOST}" -user "${MYSQL_USER}" --password "${MYSQL_PASS}"' >> setup-and-run.sh && \

# expose port 22 & 80
EXPOSE 22 80

# And start up the slave
ENTRYPOINT ./setup-and-run.sh && apache2-foreground
CMD ./setup-and-run.sh && apache2-foreground
