#
# Preconfigure traefik, for use with rancher as a backend
#
# VERSION               1.0.1
FROM traefik:v1.4.0-rc2-alpine

# Make the directory for config
RUN mkdir -p /etc/traefik/

# Port to expose, this is currently fixed to 80 for HTTP, and 8000 for admin
EXPOSE 80 8000

########################### Environment configurations start ###########################

###
#
# Traefik & rancher health check integration settings.
# Recommendation is to disable (false), unless the rancher healthcheck cycle and use case
# is properly tested, to prevent false negatives from failing the system.
#
# Especially in a large fleet of unique microservices, where a single server failover
# may not have a failover for its respective service anyway for traefik.
#
# Ideally (but it isnt) that traefik should be like AWS loadbalancer, in event if all instances fail 
# healthchecck it fallsback to try route to all instances anyway : protecting the system from possible
# complete false negatives from shutting down the entire loadbalancer.
#
###

# Filter using rancher healthcheck
ENV TRAEFIK_SERVICE_HEALTH_FILTER false

###
#
# Adjust the traefik polling of rancher metadata service
# Either via longpolling, or repeated intervals
#
###

# Traefik interval polling mode
# false : uses long polling where changes are "live"
# true : does a sync every X refresh seconds
ENV TRAEFIK_INTERVAL_POLL false

# Polliing interval : default 5 seconds
# This setting is only relevant together with TRAEFIK_INTERVAL_POLL = true
ENV TRAEFIK_REFRESH_SECONDS 5

###
#
# Auto registration of traefik servers with default domains
# Highly NOT recommended, unless for internal uses cases,
# in which rancher internal domains are preferred
#
###

# Auto register servers with default settings in traefik
ENV TRAEFIK_EXPOSE_BY_DEFAULT false

# Auto register servers with the given domain name
ENV TRAEFIK_DEFAULT_DOMAIN "rancher.localhost"

########################### Environment configurations end ###########################

#
# Prepares the configuration primer script, and runs it once
#
RUN echo '#!/bin/sh'                                                                                          >  /config-setup.sh && \
	echo '# Indside the traefik config folder'                                                                 >> /config-setup.sh && \
	echo 'cd /etc/traefik/;'                                                                                   >> /config-setup.sh && \
	echo ''                                                                                                    >> /config-setup.sh && \
	echo 'echo "# Traefik HTTP Entrypoint configuration"                                      >  traefik.toml' >> /config-setup.sh && \
	echo 'echo "[entryPoints]"                                                                >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "   [entryPoints.http]"                                                        >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "   address = \":80\""                                                         >> traefik.toml' >> /config-setup.sh && \
	echo 'echo ""                                                                             >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "# Traefik admin entrypoint"                                                   >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "[web]"                                                                        >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "address = \":8000\""                                                          >> traefik.toml' >> /config-setup.sh && \
	echo 'echo ""                                                                             >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "# Rancher configuration"                                                      >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "[rancher]"                                                                    >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "watch = true"                                                                 >> traefik.toml' >> /config-setup.sh && \
	echo 'echo ""                                                                             >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "exposedByDefault = $TRAEFIK_EXPOSE_BY_DEFAULT"                                >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "domain = \"$TRAEFIK_DEFAULT_DOMAIN\""                                         >> traefik.toml' >> /config-setup.sh && \
	echo 'echo ""                                                                             >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "enableServiceHealthFilter = $TRAEFIK_SERVICE_HEALTH_FILTER"                   >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "refreshSeconds = $TRAEFIK_REFRESH_SECONDS"                                    >> traefik.toml' >> /config-setup.sh && \
	echo 'echo ""                                                                             >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "[rancher.metadata]"                                                           >> traefik.toml' >> /config-setup.sh && \
	echo 'echo "intervalPoll = $TRAEFIK_INTERVAL_POLL"                                        >> traefik.toml' >> /config-setup.sh && \
	echo ''                                                                                                    >> /config-setup.sh && \
	echo '# Goes back to root folder'                                                                          >> /config-setup.sh && \
	echo 'cd /'                                                                                                >> /config-setup.sh && \
	echo ''                                                                                                    >> /config-setup.sh && \
	echo '# Chain the execution commands'                                                                      >> /config-setup.sh && \
	echo 'exec "$@"'                                                                                           >> /config-setup.sh && \
	chmod +x /config-setup.sh && \
	/config-setup.sh;

#
# Entrypoint with config
#
ENTRYPOINT ["/config-setup.sh", "/entrypoint.sh"]