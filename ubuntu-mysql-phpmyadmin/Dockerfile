# ubuntu-mysql-phpmyadmin
#
# VERSION               0.0.1
#
# Also sets language to en_US.UTF-8 by default
#
FROM ubuntu:14.04
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common

# Sets language to UTF8 : this works in pretty much all cases
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Setup mysql user / pass for headless install
ENV MYSQL_ROOT_PASSWORD password_pls_change

RUN sudo debconf-set-selections << 'mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD'
RUN sudo debconf-set-selections << 'mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD'

# MySQL installation
RUN apt-get update && apt-get install -y mysql-server

# Expose port 3306 (Mysql)
EXPOSE 3306

# Install apache2, phpmyadmin
RUN apt-get update && apt-get install -y apache2 phpmyadmin

# Install mcrypt
RUN php5enmod mcrypt

# Expose port 80 (phpmyadmin)
EXPOSE 80

# Run mysql service & apache
ENTRYPOINT service mysql start && /usr/sbin/apache2ctl -D FOREGROUND
CMD service mysql start && /usr/sbin/apache2ctl -D FOREGROUND