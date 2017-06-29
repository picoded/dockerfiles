# Provides a TCP proxy, to err bounce TCP signals
#
# VERSION               1.0.1
#
FROM            haproxy:1.7-alpine
MAINTAINER      Eugene Cheah <eugene@picoded.com>

# The TCP proxy configuration vars
ENV HOST_PORT 80
ENV FORWARD_HOST targethost
ENV FORWARD_PORT 80

# The custom haproxy.cfg for tcp proxy
RUN cd /usr/local/etc/haproxy && \
	echo 'frontend frontend'                                          >  haproxy.cfg && \
	echo '   bind 0.0.0.0:$HOST_PORT'                                 >> haproxy.cfg && \
	echo '   mode tcp'                                                >> haproxy.cfg && \
	echo '   log global'                                              >> haproxy.cfg && \
	echo '   option tcplog'                                           >> haproxy.cfg && \
	echo '   timeout client 3600s'                                    >> haproxy.cfg && \
	echo '   backlog 4096'                                            >> haproxy.cfg && \
	echo '   maxconn 50000'                                           >> haproxy.cfg && \
	echo '   default_backend backend'                                 >> haproxy.cfg && \
	echo ''                                                           >> haproxy.cfg && \
	echo 'backend backend'                                            >> haproxy.cfg && \
	echo '   mode tcp'                                                >> haproxy.cfg && \
	echo '   option log-health-checks'                                >> haproxy.cfg && \
	echo '   option redispatch'                                       >> haproxy.cfg && \
	echo '   option tcplog'                                           >> haproxy.cfg && \
	echo '   balance roundrobin'                                      >> haproxy.cfg && \
	echo '   server backend_host $FORWARD_HOST:$FORWARD_PORT'         >> haproxy.cfg && \
	echo '   timeout connect 2s'                                      >> haproxy.cfg && \
	echo '   timeout queue 5s'                                        >> haproxy.cfg && \
	echo '   timeout server 3600s'                                    >> haproxy.cfg;
