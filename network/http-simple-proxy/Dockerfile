# Provides a nginx proxy, from one http to another =)
#
# VERSION               1.0.1
#
FROM            nginx:alpine
MAINTAINER      Eugene Cheah <eugene@picoded.com>

# Makes only the entry point, no other points needed
RUN mkdir /entrypoint;

# Port to expose, this is currently fixed to 80
EXPOSE 80

##########################
#
# Common nginx settings
#
##########################

# Server host to make request to,
# you may use a named container of "webhost" instead
ENV FORWARD_HOST webhost

# The destination server port
ENV FORWARD_PORT 80

# The forwarding protocall
ENV FORWARD_PROT "http"

# Nginx proxy read timed, default is 600 seconds (10 minutes)
ENV PROXY_READ_TIMEOUT 600s

# Nginx proxy initial connection timeout, default is 5 seconds
ENV PROXY_CONNECT_TIMEOUT 5s

# Client max body size conig (default disabled)
ENV MAX_BODY_SIZE 100M

# Client buffer size, before writing a tmp file
ENV MAX_BUFFER_SIZE 10M

# DNS server to use (if configured)
ENV DNS ""

# DNS Validity timeframe
#
# This can be set as blank to follow DNS declared settings
# intentionally set to 10s to avoid DNS storms
ENV DNS_VALID_TIMEOUT 10s

##########################
#
# Advance nginx settings
#
##########################

# The forward upstream to use within the 
# "upstream backend { ... }" block.
#
# Note that using this setting WILL cause the
# FORWARD_HOST / FORWARD_PORT settings to be ignored
#
# An example fail over format would be the following
#
# ```
# server primaryServer:80 fail_timeout=1s;
# server backupServer:80 backup;
# ```
#
ENV FORWARD_UPSTREAM ""

# Zone upstream size
#
# This is required, for the resolver to work,
# Default is 1m which is enough for almost all cases.
ENV UPSTREAM_ZONE_SIZE 1m

# Automatic failover on multiple upstream, if configured
# Note that this is only useful in conjuncture with FORWARD_UPSTREAM
ENV PROXY_NEXT_UPSTREAM "error timeout invalid_header http_500 http_502 http_503 http_504 http_403 http_404 http_429"

# Additional Custom nginx http level setting to add (if applicable)
ENV NGINX_HTTP_CONFIG ""

# Additional Custom nginx server level setting to add (if applicable)
ENV NGINX_SERVER_CONFIG ""

# Additional Custom nginx root location level setting to add (if applicable)
ENV NGINX_ROOT_LOCATION_CONFIG ""

##########################
#
# @TODO : Cache settings support?
#
##########################

#
# Prepares the entrypoint primer script, and runs it once
#
RUN echo '#!/bin/sh'                                                                                         > /entrypoint/primer.sh && \
	echo '# Fetch the DNS resolver'                                                                           >> /entrypoint/primer.sh && \
	echo 'RESOLVER="$DNS"'                                                                                    >> /entrypoint/primer.sh && \
	echo 'if [ -z "$RESOLVER" ]; then'                                                                        >> /entrypoint/primer.sh && \
	echo '    RESOLVER=$(cat /etc/resolv.conf | grep "nameserver" | awk "{print \$2}")'                       >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                 >> /entrypoint/primer.sh && \
	echo ''                                                                                                   >> /entrypoint/primer.sh && \
	echo 'if [ -n "$DNS_VALID_TIMEOUT" ]; then'                                                               >> /entrypoint/primer.sh && \
	echo '    RESOLVER="$RESOLVER valid=$DNS_VALID_TIMEOUT"'                                                  >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                 >> /entrypoint/primer.sh && \
	echo 'echo "resolver $RESOLVER ;" > /etc/nginx/resolvers.conf'                                            >> /entrypoint/primer.sh && \
	echo ''                                                                                                   >> /entrypoint/primer.sh && \
	echo '# Goes into the nginx config folder'                                                                >> /entrypoint/primer.sh && \
	echo 'cd /etc/nginx/conf.d/'                                                                              >> /entrypoint/primer.sh && \
	echo ''                                                                                                   >> /entrypoint/primer.sh && \
	echo '# Setup the server config'                                                                          >> /entrypoint/primer.sh && \
	echo 'echo "# http level config"                                                         > default.conf'  >> /entrypoint/primer.sh && \
	echo 'echo "client_max_body_size ${MAX_BODY_SIZE};"                                      >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "# Dynamic IP DNS workaround"                                                 >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "include resolvers.conf;"                                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "upstream forward_backend {"                                                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   zone forward_backend_zone ${UPSTREAM_ZONE_SIZE};"                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'if [ -n "$FORWARD_UPSTREAM" ]; then'                                                                >> /entrypoint/primer.sh && \
	echo 'if [[ "${FORWARD_UPSTREAM: -1}" == ";" ]]; then'                                                    >> /entrypoint/primer.sh && \
	echo 'echo "   ${FORWARD_UPSTREAM}"                                                      >> default.conf' >> /entrypoint/primer.sh && \
	echo 'else'                                                                                               >> /entrypoint/primer.sh && \
	echo 'echo "   ${FORWARD_UPSTREAM};"                                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                 >> /entrypoint/primer.sh && \
	echo 'else'                                                                                               >> /entrypoint/primer.sh && \
	echo 'echo "   server ${FORWARD_HOST}:${FORWARD_PORT};"                                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                 >> /entrypoint/primer.sh && \
	echo 'echo "}"                                                                           >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "# Custom NGINX http level config (if applicable)"                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "${NGINX_HTTP_CONFIG}"                                                        >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "server {"                                                                    >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   listen 80 default_server;"                                                >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   client_max_body_size ${MAX_BODY_SIZE};"                                   >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # Proxy next upstream handling (if applicable)"                           >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   ${NGINX_SERVER_CONFIG}"                                                   >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # Additional Nginx server level config (if applicable)"                   >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   proxy_next_upstream ${PROXY_NEXT_UPSTREAM};"                              >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   location / {"                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_pass                    ${FORWARD_PROT}://forward_backend;"      >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_connect_timeout         ${PROXY_CONNECT_TIMEOUT};"               >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_read_timeout            ${PROXY_READ_TIMEOUT};"                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_pass_request_headers    on;"                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_set_header     X-Forwarded-For \$proxy_add_x_forwarded_for;"     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      client_max_body_size ${MAX_BODY_SIZE};"                                >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      client_body_buffer_size ${MAX_BUFFER_SIZE};"                           >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      # Additional Nginx root location level config (if applicable)"         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      ${NGINX_ROOT_LOCATION_CONFIG}"                                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   }"                                                                        >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "}"                                                                           >> default.conf' >> /entrypoint/primer.sh && \
	echo ''                                                                                                   >> /entrypoint/primer.sh && \
	echo '# Goes back to root folder'                                                                         >> /entrypoint/primer.sh && \
	echo 'cd /'                                                                                               >> /entrypoint/primer.sh && \
	echo ''                                                                                                   >> /entrypoint/primer.sh && \
	echo '# Chain the execution commands'                                                                     >> /entrypoint/primer.sh && \
	echo 'exec "$@"'                                                                                          >> /entrypoint/primer.sh && \
	chmod +x /entrypoint/primer.sh && \
	/entrypoint/primer.sh;

#
# Usef  ul for debugging
#
# RUN cat /etc/nginx/conf.d/default.conf;
# RUN cat /entrypoint/primer.sh;

ENTRYPOINT ["/entrypoint/primer.sh"]
CMD nginx -g "daemon off;"
