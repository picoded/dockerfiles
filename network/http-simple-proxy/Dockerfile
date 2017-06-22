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

#
# Server host to make request to, 
# you may use a named container of "webhost" instead
#
ENV FORWARD_HOST webhost

# The destination server port
ENV FORWARD_PORT 80

# The forwarding protocall
ENV FORWARD_PROT "http"

# Nginx proxy read timed, default is 600 seconds (10 minutes)
ENV PROXY_READ_TIMEOUT 600

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

#
# Prepares the entrypoint primer script, and runs it once
#
RUN echo '#!/bin/sh'                                                                                         > /entrypoint/primer.sh && \
	echo '# Fetch the DNS resolver'                                                                           >> /entrypoint/primer.sh && \
	echo 'RESOLVER="$DNS"'                                                                                    >> /entrypoint/primer.sh && \
	echo 'if [ -z "$RESOLVER" ]; then'                                                                        >> /entrypoint/primer.sh && \
	echo '    RESOLVER=$(cat /etc/resolv.conf | grep "nameserver" | awk "{print \$2}")'                       >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                 >> /entrypoint/primer.sh && \
	echo 'if [ -z "$DNS_VALID_TIMEOUT" ]; then'                                                               >> /entrypoint/primer.sh && \
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
	echo 'echo "server {"                                                                    >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   listen 80 default_server;"                                                >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   client_max_body_size ${MAX_BODY_SIZE};"                                   >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   location / {"                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      # Dynamic IP DNS workaround"                                           >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      include resolvers.conf;"                                               >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      set \$upstream \"${FORWARD_PROT}://${FORWARD_HOST}:${FORWARD_PORT}\";" >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_pass                    \$upstream;"                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_read_timeout            ${PROXY_READ_TIMEOUT};"                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_pass_request_headers    on;"                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      proxy_set_header     X-Forwarded-For \$proxy_add_x_forwarded_for;"     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      client_max_body_size ${MAX_BODY_SIZE};"                                >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "      client_body_buffer_size ${MAX_BUFFER_SIZE};"                           >> default.conf' >> /entrypoint/primer.sh && \
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
