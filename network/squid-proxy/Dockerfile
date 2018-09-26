# Provides a squid forward proxy, with an authtication layer
#
# VERSION               1.0.1
FROM alpine:latest

# install a specific version of squid + curl
# and dependencies for envsubst (needed for config)
RUN apk update \
    && apk add squid=3.5.27-r2 \
    && apk add curl \
    && apk add gettext \
    && apk add libintl \
    && apk add apache2-utils \
    && rm -rf /var/cache/apk/*

# Create the entrypoint folder and log dir
RUN mkdir -p /entrypoint && mkdir -p /workspace && mkdir -p /var/log/squid
VOLUME /var/log/squid
VOLUME /workspace

# Change working directory (to execute from)
WORKDIR /workspace

# Import the config file, and the entrypoint script
ADD squid-template.conf /entrypoint/squid-template.conf
ADD entrypoint.sh /entrypoint/squid-entrypoint.sh
RUN chmod +x /entrypoint/*.sh

# HTTP AUTH username and password for the proxy
ENV USERNAME=proxy_user \
	PASSWORD=proxy_password

# Permitted IP addresses for the proxy
# ENV ALLOWED_IP_RANGE=0.0.0.0/0

# Indicate the proxy port should be 3128
EXPOSE 3128/tcp

# Run the entrypoint script to test if it works
# RUN /entrypoint/squid-entrypoint.sh

# Overwrite the entrypoint script
ENTRYPOINT /entrypoint/squid-entrypoint.sh
CMD []