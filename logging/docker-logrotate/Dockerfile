FROM alpine
MAINTAINER eugene@picoded.com

# Logrotate installation
RUN apk --update add logrotate

# Configure cron to run every 15 minutes
RUN echo "*/5 *	* * *	/usr/sbin/logrotate /etc/logrotate.conf" >> /etc/crontabs/root

# Volume to attach
VOLUME /var/lib/docker/containers

# The logrotate configuration file
RUN echo "/var/lib/docker/containers/*/*.log {" >  /etc/logrotate.conf && \
	# Log files are rotated daily
	echo "   daily"                              >> /etc/logrotate.conf && \
	# Log files are rotated after they grow bigger than <size> in bytes
	echo "   size 1M"                            >> /etc/logrotate.conf && \
	# Log files are rotated after they grow bigger than <size> in bytes, 
	# regardless of time frame configured. This is for excessive large logs.
	echo "   maxsize 10M"                        >> /etc/logrotate.conf && \
	# Log files are rotated <count> times before being removed
	# 9 should cover 9-10 days, unless excessive amount of logs occur
	# Capping the maximum log size per container to be +/- 100 MB
	echo "   rotate 9"                           >> /etc/logrotate.conf && \
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