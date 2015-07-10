# ssh-apache-php
#
# VERSION               0.0.2
#
# Note this is referenced from : https://docs.docker.com/examples/running_ssh_service/
#
FROM picoded/ssh
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# run update and install apache2 webstack
RUN apt-get update && RUN apt-get install -y python apache2 php5 libapache2-mod-php5 php5-mcrypt php5-cli

# install common package utility
RUN apt-get install -y git unzip zip

# move the default /var/www contents to /workspace/www
RUN mkdir /workspace && mkdir /workspace/www && mv /var/www/html/index.html /workspace/www/ 

# and relinks /var/www/html to /workspace/www
RUN rmdir /var/www/html && ln -s /workspace/www /var/www && cd /var/www && mv www html 

# Volume links
VOLUME ["/workspace/www", "/var/log/apache2", "/etc/apache2"]

# expose port 80
EXPOSE 80 443

# And start up the slave
ENTRYPOINT service ssh start && /usr/sbin/apache2ctl -D FOREGROUND
CMD service ssh start && /usr/sbin/apache2ctl -D FOREGROUND