# Provides a simplified openldap server
# This is meant for a simple, single domain ldap
# This is for small to medium group size 
#
# For extremely large group size, such as 100k users
# you may want a custom LDAP solution with an expert
#
# VERSION               1.0.0
#
FROM            alpine:latest
MAINTAINER      Eugene Cheah <eugene@picoded.com>

RUN apk add --no-cache openldap openldap-clients openldap-back-hdb openldap-back-bdb ldapvi

# The ldap ports to expose
# By default LDAP port is 389.
# For its SSL port, its 636
EXPOSE 389 636

# Makes only the entry point, no other points needed
RUN mkdir /entrypoint;

# Setup the "WORKDIR"
WORKDIR /etc/openldap/

# The LDAP root password (DO change this value)
# This password is setup on start
ENV LDAP_ROOTPASS "P@ssw0rd!"

# The domain suffix to use
# This is usually corresponding to your company
# domain name such as sg.my-domain.com
ENV LDAP_DOMAIN "dc=company,dc=com"

# The root context (which belongs to the same domain)
ENV LDAP_ROOTCN "cn=admin"

#
# Prepares the entrypoint primer script, and runs it once
#
RUN echo '#!/bin/sh'                                                                   > /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# Goes into the config folder'                                                >> /entrypoint/primer.sh && \
	echo 'cd /etc/openldap/'                                                            >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# Setting up ldap domain'                                                     >> /entrypoint/primer.sh && \
	echo 'echo ">> Setting up domains"'                                                 >> /entrypoint/primer.sh && \
	echo 'sed -i "s|suffix.*|suffix       \"$LDAP_DOMAIN\"|g" slapd.conf'               >> /entrypoint/primer.sh && \
	echo 'sed -i "s|rootdn.*|rootdn       \"$LDAP_ROOTCN,$LDAP_DOMAIN\"|g" slapd.conf'  >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# Setting up root password'                                                   >> /entrypoint/primer.sh && \
	echo 'echo ">> Setting up root password"'                                           >> /entrypoint/primer.sh && \
	echo 'LDAP_ROOTPASSHASH=$(slappasswd -s "$LDAP_ROOTPASS")'                          >> /entrypoint/primer.sh && \
	echo 'sed -i "s|rootpw.*|rootpw       \"$LDAP_ROOTPASSHASH\"|g" slapd.conf'         >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# Chain the execution commands'                                               >> /entrypoint/primer.sh && \
	echo 'exec "$@"'                                                                    >> /entrypoint/primer.sh && \
	chmod +x /entrypoint/primer.sh && \
	/entrypoint/primer.sh;

ENTRYPOINT ["/entrypoint/primer.sh"]

#CMD ["sh", "-c", "tail -f /dev/null"]
CMD ulimit -n 8192 && /usr/sbin/slapd -d 256 -u ldap -g ldap 
#-d 256 -u ldap -g ldap 
#-F /etc/openldap/