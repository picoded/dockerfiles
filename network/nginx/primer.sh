#!/bin/sh  

# Goes into the nginx config folder 
cd /etc/nginx/conf.d/  

#
# Fetch the DNS resolver
# - either via environment variable
# - or docker container configured nameserver
#
RESOLVER="$DNS"
if [ -z "$RESOLVER" ]; then
RESOLVER=$(cat /etc/resolv.conf | grep "nameserver" | awk "{print \$2}")  
fi
if [ -n "$DNS_VALID_TIMEOUT" ]; then
RESOLVER="$RESOLVER valid=$DNS_VALID_TIMEOUT"
fi
echo "resolver $RESOLVER ;" > /etc/nginx/resolvers.conf  

#
# /etc/nginx/nginx.conf settings
#
if [ -z "$NGINX_CONF" ]; then
NGINX_CONF=$(echo "
user  nginx;
worker_processes  $WORKER_PROCESSES;

# Default error log and pid
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;

# Set a limit to 10k * worker_processes
events {
	worker_connections  $WORKER_CONNECTIONS;
}

# Setup http process, and its logging format
http {
	include       /etc/nginx/mime.types;
	default_type  application/octet-stream;

	# Default access log
	log_format  main  '$remote_addr - $remote_user [$time_local] \"$request\" '
	                  '$status $body_bytes_sent "$http_referer" '
	                  '\"$http_user_agent\" \"$http_x_forwarded_for\"';
	access_log  /var/log/nginx/access.log  main;

	# DNS address resolver support
	include resolvers.conf;

	# http level config of client request size
	client_max_body_size $CLIENT_MAX_BODY_SIZE;
	client_body_buffer_size $CLIENT_MAX_BUFFER_SIZE;

	# Enable send file by default
	sendfile        on;

	# Include the various confi.d/*.conf files
	include /etc/nginx/conf.d/*.conf;
}
")
fi
echo "$NGINX_CONF" > /etc/nginx/nginx.conf

#
# Echo out assumed nginx settings
#
echo ">>> Assuming the following for - /etc/nginx/nginx.conf"
cat /etc/nginx/nginx.conf
echo ">>>"

#
# /etc/nginx/conf.d/default.conf settings
#
if [ -z "$DEFAULT_CONF" ]; then
	echo ">>> [Skipping] /etc/nginx/conf.d/default.conf - as DEFAULT_CONF is blank"
else
	echo "$DEFAULT_CONF" > /etc/nginx/conf.d/default.conf
fi

#
# Echo out assumed nginx settings
#
echo ">>> Assuming the following for - /etc/nginx/conf.d/default.conf"
cat /etc/nginx/conf.d/default.conf
echo ">>>"

#
# Goes back to root folder and
# Chain the execution commands 
#
cd /  
exec "$@" >> /entrypoint/primer.sh