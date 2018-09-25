FROM ubuntu:16.04

ADD squid.conf /home/ubuntu/squid/

ENV SQUID_VERSION=3.3.8 \
    SQUID_CACHE_DIR=/var/spool/squid \
	SQUID_CONF_DIR=/etc/squid3 \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy \
    USERNAME=proxy_user \
    PASSWORD=proxy_password \
	ALLOWED_IP_RANGE=0.0.0.0/0

RUN apt update \
 && apt install -y squid3 \
 && apt install -y apache2-utils\
 && htpasswd -bc $SQUID_CONF_DIR/passwd $USERNAME $PASSWORD

#RUN echo $SQUID_CONF > /etc/squid/squid.conf

RUN echo "#!/bin/bash"                                                                   >> /sbin/entrypoint.sh && \
	# Original script is located at https://github.com/sameersbn/docker-squid/blob/master/entrypoint.sh
	echo "set -e"                                                                        >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "create_log_dir() {"                                                            >> /sbin/entrypoint.sh && \
	echo "  mkdir -p \${SQUID_LOG_DIR}"                                                  >> /sbin/entrypoint.sh && \
	echo "  chmod -R 755 \${SQUID_LOG_DIR}"                                              >> /sbin/entrypoint.sh && \
	echo "  chown -R \${SQUID_USER}:\${SQUID_USER} \${SQUID_LOG_DIR}"                    >> /sbin/entrypoint.sh && \
	echo "}"                                                                             >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "create_cache_dir() {"                                                          >> /sbin/entrypoint.sh && \
	echo "  mkdir -p \${SQUID_CACHE_DIR}"                                                >> /sbin/entrypoint.sh && \
	echo "  chown -R \${SQUID_USER}:\${SQUID_USER} \${SQUID_CACHE_DIR}"                  >> /sbin/entrypoint.sh && \
	echo "}"                                                                             >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "apply_backward_compatibility_fixes() {"                                        >> /sbin/entrypoint.sh && \
	echo "  if [[ -f /etc/squid/squid.user.conf ]]; then"                                >> /sbin/entrypoint.sh && \
	echo "    rm -rf /etc/squid/squid.conf"                                              >> /sbin/entrypoint.sh && \
	echo "    ln -sf /etc/squid/squid.user.conf /etc/squid/squid.conf"                   >> /sbin/entrypoint.sh && \
	echo "  fi"                                                                          >> /sbin/entrypoint.sh && \
	echo "}"                                                                             >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "CONFIG_FILE_DATA_ORI=\$(cat \$/home/ubuntu/squid/squid.conf)"                  >> /sbin/entrypoint.sh && \
	echo "CONFIG_FILE_DATA=\$(echo '\$CONFIG_FILE_DATA_ORI' | envsubst)"                 >> /sbin/entrypoint.sh && \
	echo "if [[ -z '\$CONFIG_FILE_DATA' ]]; then"                                        >> /sbin/entrypoint.sh && \
	echo "  echo '\$CONFIG_FILE_DATA' > \$SQUID_CONF_DIR/squid.conf"                     >> /sbin/entrypoint.sh && \
	echo "fi"                                                                            >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "create_log_dir"                                                                >> /sbin/entrypoint.sh && \
	echo "create_cache_dir"                                                              >> /sbin/entrypoint.sh && \
	echo "apply_backward_compatibility_fixes"                                            >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "# allow arguments to be passed to squid3"                                      >> /sbin/entrypoint.sh && \
	echo "if [[ \${1:0:1} = '-' ]]; then"                                                >> /sbin/entrypoint.sh && \
	echo "  EXTRA_ARGS=\"$@\""                                                           >> /sbin/entrypoint.sh && \
	echo "  set --"                                                                      >> /sbin/entrypoint.sh && \
	echo "elif [[ \${1} == squid || \${1} == $(which squid) ]]; then"                    >> /sbin/entrypoint.sh && \
	echo "  EXTRA_ARGS=\"\${@:2}\""                                                      >> /sbin/entrypoint.sh && \
	echo "  set --"                                                                      >> /sbin/entrypoint.sh && \
	echo "fi"                                                                            >> /sbin/entrypoint.sh && \
	echo ""                                                                              >> /sbin/entrypoint.sh && \
	echo "# default behaviour is to launch squid"                                        >> /sbin/entrypoint.sh && \
	echo "if [[ -z \${1} ]]; then"                                                       >> /sbin/entrypoint.sh && \
	echo "  if [[ ! -d \${SQUID_CACHE_DIR}/00 ]]; then"                                  >> /sbin/entrypoint.sh && \
	echo "    echo \"Initializing cache...\""                                            >> /sbin/entrypoint.sh && \
	echo "    $(which squid) -N -f /etc/squid/squid.conf -z"                             >> /sbin/entrypoint.sh && \
	echo "  fi"                                                                          >> /sbin/entrypoint.sh && \
	echo "  echo \"Starting squid3...\""                                                 >> /sbin/entrypoint.sh && \
	echo "  exec $(which squid) -f /etc/squid/squid.conf -NYCd 1 \${EXTRA_ARGS}"         >> /sbin/entrypoint.sh && \
	echo "else"                                                                          >> /sbin/entrypoint.sh && \
	echo "  exec \"$@\""                                                                 >> /sbin/entrypoint.sh && \
	echo "fi"                                                                            >> /sbin/entrypoint.sh


RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
