# Provides a squid forward proxy, with an authtication layer
#
# VERSION               1.0.1
FROM sameersbn/squid:3.3.8-23

# Dependencies for envsubst and htpassword (needed for config)
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y gettext \
    && apt-get install -y apache2-utils \
    && rm -rf /var/lib/apt/lists/*

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

# Enable debugging
ENV SQUID_DEBUG=false

# Permitted IP addresses for the proxy
# ENV ALLOWED_IP_RANGE=0.0.0.0/0

# Indicate the proxy port should be 3128
EXPOSE 3128/tcp

# Run the entrypoint script to test if it works
# RUN /entrypoint/squid-entrypoint.sh

# Overwrite the entrypoint script
ENTRYPOINT /entrypoint/squid-entrypoint.sh
CMD []