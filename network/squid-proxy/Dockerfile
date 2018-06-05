FROM datadog/squid

EXPOSE 3128 3128

ENV USERNAME proxy_user
ENV PASSWORD proxy_password

RUN apt update && apt install -y apache2-utils && htpasswd -bc /etc/squid/passwd $USERNAME $PASSWORD && /usr/lib/squid3/basic_ncsa_auth /etc/squid/passwd &&
    echo "auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd"  > /etc/squid/squid.conf
    echo "auth_param basic children 5" >> /etc/squid/squid.conf
    echo ""
    echo "auth_param basic realm Squid proxy-caching web server"
    echo "auth_param basic credentialsttl 2 hours"
    echo "auth_param basic casesensitive off"
    echo ""
    echo "acl ncsa_users proxy_auth REQUIRED"
    echo "http_access allow ncsa_users"

