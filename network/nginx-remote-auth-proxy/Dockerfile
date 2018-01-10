# Provides a nginx proxy, with an authtication layer
#
# VERSION               1.0.1
#
FROM            nginx:alpine
MAINTAINER      TIONG JIA MING <jiaming@picoded.com>

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

#
# Server host / url to make auth request to
#
ENV AUTH_URL http://authhost/account/authentication-code

#
# URL to redirect if auth fail
#
ENV LOGIN_URL http://loginserver/loginpage
# either proxy or redirect
ENV LOGIN_URL_MODE="proxy"

# Nginx proxy read timed, default is 600 seconds (10 minutes)
ENV PROXY_READ_TIMEOUT 600

# Client max body size conig (default 100M)
ENV MAX_BODY_SIZE 100M

# Client buffer size, before writing a tmp file
ENV MAX_BUFFER_SIZE 10M

# DNS server to use (if configured)
ENV DNS ""

# Regex used to bypass authentication layer
# For exampe ^/(assets|css|js)/.*$
ENV AUTH_BYPASS_REGEX ""

# DNS Validity timeframe
#
# This can be set as blank to follow DNS declared settings
# intentionally set to 10s to avoid DNS storms
ENV DNS_VALID_TIMEOUT 1s

#
# Prepares the entrypoint primer script, and runs it once
#
RUN echo '#!/bin/sh'                                                                                          > /entrypoint/primer.sh && \
	echo '# Fetch the DNS resolver'                                                                            >> /entrypoint/primer.sh && \
	echo 'RESOLVER="$DNS"'                                                                                     >> /entrypoint/primer.sh && \
	echo 'if [ -z "$RESOLVER" ]; then'                                                                         >> /entrypoint/primer.sh && \
	echo '    RESOLVER=$(cat /etc/resolv.conf | grep "nameserver" | awk "{print \$2}")'                        >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                  >> /entrypoint/primer.sh && \
	echo 'if [ -n "$DNS_VALID_TIMEOUT" ]; then'                                                                >> /entrypoint/primer.sh && \
	echo '    RESOLVER="$RESOLVER valid=$DNS_VALID_TIMEOUT"'                                                   >> /entrypoint/primer.sh && \
	echo 'fi'                                                                                                  >> /entrypoint/primer.sh && \
	echo 'echo "resolver $RESOLVER ;" > /etc/nginx/resolvers.conf'                                             >> /entrypoint/primer.sh && \
	echo ''                                                                                                    >> /entrypoint/primer.sh && \
	echo '# Writes and setup the password'                                                                     >> /entrypoint/primer.sh && \
	echo 'echo "${HTPASSWD}" > /etc/nginx/auth.htpasswd'                                                       >> /entrypoint/primer.sh && \
	echo ''                                                                                                    >> /entrypoint/primer.sh && \
	echo '# Goes into the nginx config folder'                                                                 >> /entrypoint/primer.sh && \
	echo 'cd /etc/nginx/conf.d/'                                                                               >> /entrypoint/primer.sh && \
	echo ''                                                                                                    >> /entrypoint/primer.sh && \
	echo '# Setup the server config'                                                                           >> /entrypoint/primer.sh && \
	echo 'echo "# http level config"                                                          > default.conf'  >> /entrypoint/primer.sh && \
	echo 'echo "client_max_body_size ${MAX_BODY_SIZE};"                                       >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "server {"                                                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   listen 80 default_server;"                                                 >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   client_max_body_size ${MAX_BODY_SIZE};"                                    >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # Dynamic IP DNS workaround"                                               >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   include /etc/nginx/resolvers.conf;"                                        >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # Handle any 401 errors, direct to /error401"                              >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   error_page 401 /error401;"                                                 >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # Redirect user to login page"                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   location = /error401 {"                                                    >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     internal;"                                                               >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     set \$escape_uri \$request_uri;"                                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'if [  "${LOGIN_URL_MODE}" == "redirect" ]; then                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     return ${LOGIN_URL}?sourceurl=\$original_url;"                        >> default.conf' >> /entrypoint/primer.sh && \
	echo 'else                                                                                >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_set_header Host \$host;"                                        >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;"        >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_set_header X-REAL-IP \$remote_addr;"                            >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_pass ${LOGIN_URL}?sourceurl=\$escape_uri;"                      >> default.conf' >> /entrypoint/primer.sh && \
	echo 'fi                                                                                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   }"                                                                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # All endpoints to hit here"                                               >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   location / {"                                                              >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     set \$original_url \$scheme://\$http_host\$request_uri;"                 >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     # Performs subrequest to check if allow"                                 >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     auth_request /auth;"                                                     >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     auth_request_set \$auth_status \$upstream_status;"                       >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     # Forward to the respective url"                                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     set \$upstream \"${FORWARD_PROT}://${FORWARD_HOST}:${FORWARD_PORT}\";"   >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_set_header Host \$host;"                                           >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_pass \$upstream;"                                                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_read_timeout   ${PROXY_READ_TIMEOUT};"                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   }"                                                                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'if [  -n "${AUTH_BYPASS_REGEX}" ]; then                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "   location ~ ${AUTH_BYPASS_REGEX} {"                                      >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     # Forward to the respective url"                                      >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     set \$upstream \"${FORWARD_PROT}://${FORWARD_HOST}:${FORWARD_PORT}\";">> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_set_header Host \$host;"                                        >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_pass \$upstream;"                                               >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "     proxy_read_timeout   ${PROXY_READ_TIMEOUT};"                          >> default.conf' >> /entrypoint/primer.sh && \
	echo '   echo "   }"                                                                      >> default.conf' >> /entrypoint/primer.sh && \
	echo 'fi                                                                                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo ""                                                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   # Internal routing, check with API server if user is logged in"            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   location = /auth {"                                                        >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     internal;"                                                               >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_pass_request_body off;"                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_set_header Content-Length \"\";"                                   >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_set_header X-Original-URI \$request_uri;"                          >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_set_header Host \$http_host;"                                      >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     # Force Nginx to resolve DNS everytime;"                                 >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     set \$auth_url ${AUTH_URL};"                                             >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "     proxy_pass \$auth_url;"                                                  >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "   }"                                                                         >> default.conf' >> /entrypoint/primer.sh && \
	echo 'echo "}"                                                                            >> default.conf' >> /entrypoint/primer.sh && \
	echo ''                                                                                                    >> /entrypoint/primer.sh && \
	echo '# Goes back to root folder'                                                                          >> /entrypoint/primer.sh && \
	echo 'cd /'                                                                                                >> /entrypoint/primer.sh && \
	echo ''                                                                                                    >> /entrypoint/primer.sh && \
	echo '# Chain the execution commands'                                                                      >> /entrypoint/primer.sh && \
	echo 'exec "$@"'                                                                                           >> /entrypoint/primer.sh && \
	chmod +x /entrypoint/primer.sh && \
	/entrypoint/primer.sh;

#
# Usef  ul for debugging
#
# RUN cat /etc/nginx/conf.d/default.conf;
# RUN cat /entrypoint/primer.sh;

ENTRYPOINT ["/entrypoint/primer.sh"]
CMD nginx -g "daemon off;"
