FROM alpine
MAINTAINER eugene@picoded.com

# Logrotate installation
RUN apk --update add logrotate

# Configure cron to run every 5 minutes
RUN echo "*/5 *	* * *	/usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root

# Volume to attach
VOLUME /var/lib/docker/containers

# The logrotate configuration file
RUN echo "/var/lib/docker/containers/*/*.log {" >  /etc/logrotate.conf && \
	# Log files are rotated after they grow bigger than <size> in bytes
	# In this case, its anything larger then a newline
	echo "   size 2"                             >> /etc/logrotate.conf && \
	# Log files are rotated <count>  times before being removed
	# 300, is enough to cover 24 hours, which 288 * 5 minutes
	echo "   rotate 300"                         >> /etc/logrotate.conf && \
	# If the log file is missing, go on to the next one without error
	echo "   missingok"                          >> /etc/logrotate.conf && \
	# Do not rotate the log file if it is empty
	echo "   notifempty"                         >> /etc/logrotate.conf && \
	# Truncate the original log file in place after creating a copy. 
	# This limitation is discussed here : https://github.com/docker/docker/issues/7333
	echo "   copytruncate"                       >> /etc/logrotate.conf && \
	echo "}"                                     >> /etc/logrotate.conf;

# Running cron in the background
CMD ["crond", "-f"]