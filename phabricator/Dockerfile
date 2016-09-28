#
# phabricator
#
# VERSION               0.1.1
#
# Note this is referenced from 
# - https://hub.docker.com/_/php/
# - https://secure.phabricator.com/book/phabricator/article/installation_guide/
#
FROM php:5-apache
MAINTAINER Eugene Cheah <eugene@picoded.com>

#########################################
#
# Depencies fetch and setup
#
#########################################

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

#
# Download phabricator and its related branches
#
RUN mkdir /phabricator && \
	cd /phabricator && \
	git clone -b stable https://github.com/phacility/libphutil.git && \
	git clone -b stable https://github.com/phacility/arcanist.git && \
	git clone -b stable https://github.com/phacility/phabricator.git && \
	git clone https://github.com/PHPOffice/PHPExcel.git && \
	chmod -R +x .;

#
# Included PHPExcel
#
RUN cd /usr/local/etc/php/conf.d/ && \
	echo 'include_path = ".:/usr/local/lib/php:/phabricator/PHPExcel/Classes"' > include_path.ini;

#
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

#
# Point and start setup in the work directory
#
WORKDIR /phabricator

#########################################
#
# Declare environment variables
#
#########################################

# Performs a phabricator upgrade on boot
# (note this can backfire, so do make due consideration on its usage)
ENV UPGRADE_ON_BOOT false

# Site base url to use
ENV BASE_URL ""

#
# MYSQL storage, host, port, user, passwords
#
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

#
# SMTP settings, provide atleast an SMTP host to configure
#
ENV SMTP_HOST ""
ENV SMTP_PORT 25
ENV SMTP_USER "phabricator"
ENV SMTP_PASS ""
ENV SMTP_PROT ""
ENV MAIL_ADAPTER "PhabricatorMailImplementationPHPMailerAdapter"

#
# More JSON local config (to add-on)
#
ENV JSON_PARAMS ""

#########################################
#
# Create actual setup-and-run script
#
#########################################

#
# The actual giant setup script
#
RUN echo "#!/bin/bash" > setup-and-run.sh && \
	echo 'INSTALL_DIR="/phabricator"' >> setup-and-run.sh && \
	echo 'PHAB_DIR="/phabricator/phabricator";' >> setup-and-run.sh && \
	echo 'PHAB_LOCAL_JSON="$PHAB_DIR/conf/local/local.json";' >> setup-and-run.sh && \
	#
	# Paths configured above, now to do PREAMBLE_SCRIPT in PHP
	#
	echo 'echo "<?php ${PREAMBLE_SCRIPT} ?>" > $PHAB_DIR/support/preamble.php;' >> setup-and-run.sh && \
	echo 'chmod +x $PHAB_DIR/support/preamble.php;' >> setup-and-run.sh && \
	#
	# UPGRADE_ON_BOOT option
	#
	echo 'if [ "$UPGRADE_ON_BOOT" = true ]; then' >> setup-and-run.sh && \
	echo '	echo "## Doing library update on bootup (UPGRADE_ON_BOOT=true)";' >> setup-and-run.sh && \
	echo '	cd $INSTALL_DIR/libphutil && git pull;' >> setup-and-run.sh && \
	echo '	cd $INSTALL_DIR/arcanist && git pull;' >> setup-and-run.sh && \
	echo '	cd $INSTALL_DIR/phabricator && git pull;' >> setup-and-run.sh && \
	echo 'else' >> setup-and-run.sh && \
	echo '	echo "## Skipping library update (UPGRADE_ON_BOOT=false)";' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	#
	# PRE_SCRIPT call ( To let you inject viruses via environment variables XD )
	#
	echo 'if [[ ! -z "$PRE_SCRIPT" ]]; then' >> setup-and-run.sh && \
	echo '	echo "## Running PRE_SCRIPT";' >> setup-and-run.sh && \
	echo '	eval ${PRE_SCRIPT};' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	#
	# START of local.json configuration setup
	# https://secure.phabricator.com/T11589
	#
	echo 'echo "## Preparing ./conf/local/local.json (See: https://secure.phabricator.com/T11589)";' >> setup-and-run.sh && \
	echo 'echo "{" > ${PHAB_LOCAL_JSON}' >> setup-and-run.sh && \
	#
	# Base URL setup
	#
	echo 'if [[ ! -z "$BASE_URL" ]]; then' >> setup-and-run.sh && \
	echo '	echo "## Applying base URL = ${BASE_URL}";' >> setup-and-run.sh && \
	echo '	echo "	\"phabricator.base-uri\":\"${BASE_URL}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	#
	# MySQL setup
	#
	echo 'echo "## Applying MySQL configurations - ${MYSQL_HOST}";' >> setup-and-run.sh && \
	echo 'echo "	\"mysql.host\":\"${MYSQL_HOST}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'echo "	\"mysql.port\":\"${MYSQL_PORT}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'echo "	\"mysql.user\":\"${MYSQL_USER}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'echo "	\"mysql.pass\":\"${MYSQL_PASS}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	#
	# Storage configuration - increased default
	#
	echo 'echo "## Applying storage configurations";' >> setup-and-run.sh && \
	echo 'echo "	\"storage.mysql-engine.max-size\":${MYSQL_FILE_STORAGE}," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	#
	# SMTP_HOST setup - for NOTIFICATION SPAM!
	#
	echo 'if [[ ! -z "$SMTP_HOST" ]]; then' >> setup-and-run.sh && \
	echo '	echo "## Applying SMTP config";' >> setup-and-run.sh && \
	echo '	echo "	\"phpmailer.mailer\":\"smtp\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo '	echo "	\"phpmailer.smtp-host\":\"${SMTP_HOST}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo '	echo "	\"phpmailer.smtp-port\":${SMTP_PORT}," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo '	echo "	\"phpmailer.smtp-user\":\"${SMTP_USER}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo '	echo "	\"phpmailer.smtp-password\":\"${SMTP_PASS}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo '	echo "	\"phpmailer.smtp-protocol\":\"${SMTP_PROT}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo '	echo "	\"metamta.mail-adapter\":\"${MAIL_ADAPTER}\"," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	#
	# JSON_PARAMS - for more JSON parameters!
	#
	echo 'if [[ ! -z "$JSON_PARAMS" ]]; then' >> setup-and-run.sh && \
	echo '	echo "	$JSON_PARAMS," >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	#
	# END of local.json configuration setup
	#
	echo 'echo "	\"\":\"\"" >> ${PHAB_LOCAL_JSON};' >> setup-and-run.sh && \
	echo 'echo "}" >> ${PHAB_LOCAL_JSON}' >> setup-and-run.sh && \
	#
	# Run the storage update
	#
	echo 'echo "## Running storage upgrade";' >> setup-and-run.sh && \
	echo '$PHAB_DIR/bin/storage upgrade --force;' >> setup-and-run.sh && \
	#
	# Start background thread if needed
	#
	echo 'if [ "$BACKGROUND_THREAD" = true ]; then' >> setup-and-run.sh && \
	echo '	echo "## Starting background thread";' >> setup-and-run.sh && \
	echo '	$PHAB_DIR/bin/phd start;' >> setup-and-run.sh && \
	echo 'fi' >> setup-and-run.sh && \
	#
	# Chmod the script to be runnable
	#
	chmod +x setup-and-run.sh;
	
# expose port 22 & 80
EXPOSE 22 80

#########################################
#
# Actually run it
#
#########################################
ENTRYPOINT ./setup-and-run.sh && apache2-foreground
CMD ./setup-and-run.sh && apache2-foreground
