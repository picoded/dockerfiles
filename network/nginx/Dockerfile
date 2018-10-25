# Provides a nginx proxy, with an authtication layer
#
# VERSION               1.0.1
#
FROM            nginx:1-alpine

# Makes the entrypoint folder
RUN mkdir -p /entrypoint;

# Port to expose, this is currently fixed to 80
EXPOSE 80

##########################################################

#
# Most common settings to adjust
#

# Client max body size conig (default 100M)
ENV CLIENT_MAX_BODY_SIZE 100M

# Client buffer size, before writing a tmp file
ENV CLIENT_MAX_BUFFER_SIZE 10M

# /etc/nginx/conf.d/default.conf overwrite (if configured)
ENV DEFAULT_CONF ""

#
# Settings you probably should 
# NOT adjust unless you know what
# you are doing
#

# DNS server to use (if configured)
ENV DNS ""

# DNS Validity timeframe
#
# This can be set as blank to follow DNS declared settings
# intentionally set to 10s to avoid DNS storms
ENV DNS_VALID_TIMEOUT 1s

# Number of worker process
ENV WORKER_PROCESSES 1

# Number of worker connections per process
ENV WORKER_CONNECTIONS 10240

# /etc/nginx/nginx.conf overwrite (if configured)
# NOTE if this is configured and used, all other configs
# parameters would be effectively useless
ENV NGINX_CONF ""

##########################################################

#
# Prepares the entrypoint primer script, echo its content (for build debugging)
# and runs it once for validation
#
COPY primer.sh /entrypoint/primer.sh
RUN chmod +x /entrypoint/primer.sh && cat /entrypoint/primer.sh 
RUN /entrypoint/primer.sh

#
# Setup the entrypoing script
# and the default nginx command
#
ENTRYPOINT ["/entrypoint/primer.sh"]
CMD nginx -g "daemon off;"
