# jenkins-slave-nginx
#
# VERSION               0.0.1
#
# Jenkins slave with nginx deployed
#
FROM picoded/jenkins-slave
MAINTAINER Eugene Cheah <eugene@picoded.com>

# install nginx
RUN apt-get update && \
	apt-get install -y nginx && \
	apt-get clean;

# Expose port 80
EXPOSE 80;

# Make sure the workspace/www folder is valid
# and copies over the relevent files
RUN mkdir -p /workspace/www && \
	cp -r /var/www/html/* /workspace/www/;

# Replace the default - 'www' directory to the new workspace www directory
RUN sed -i 's|/var/www/html|/workspace/www|g' /etc/nginx/sites-available/default;

# Disable sendfile caching, needed to ensure updates a propagated without caching
# RUN sed -i 's/sendfile on/sendfile off/g' /etc/nginx/nginx.conf;

#
# Runs nginx service
#
RUN echo "#!/bin/bash"                                                      >  /entrypoint/nginx-run.sh && \
	echo ''                                                                  >> /entrypoint/nginx-run.sh && \
	echo '# www workspace dir for nginx'                                     >> /entrypoint/nginx-run.sh && \
	echo 'mkdir -p /workspace/www/'                                          >> /entrypoint/nginx-run.sh && \
	echo ''                                                                  >> /entrypoint/nginx-run.sh && \
	echo '# run nginx'                                                       >> /entrypoint/nginx-run.sh && \
	echo 'service nginx start;'                                              >> /entrypoint/nginx-run.sh && \
	echo ''                                                                  >> /entrypoint/nginx-run.sh && \
	echo '# Chain the execution commands'                                    >> /entrypoint/nginx-run.sh && \
	echo 'exec "$@"'                                                         >> /entrypoint/nginx-run.sh && \
	chmod +x /entrypoint/nginx-run.sh;

# And start up the slave
ENTRYPOINT ["/entrypoint/primer.sh", "/entrypoint/nginx-run.sh", "/entrypoint/jenkins-run.sh"]
