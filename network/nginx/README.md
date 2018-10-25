# picoded/nginx

https://hub.docker.com/r/picoded/nginx/
https://github.com/picoded/dockerfiles/tree/master/network/nginx

## Summary and configuration
A simple nginx server, with container configured DNS resolver preloaded

``` 
#
# The htpasswd file configuration.
# Default is "picoded:{PLAIN}isAwesome!", which is unencrypted. You may overwrite with encrypted htpasswd
#
# You can use either an offline httpasswd generator (for the paranoid)
# Or an online conguration generator such as : http://aspirine.org/htpasswd_en.html
#
# Note, if you are configuring this variable via command line, you will want to use
# single quotes, to ensure the $ signs in the hashed password.
#
# You may use multiple lines, via \n "newline"
#
ENV HTPASSWD="picoded:{PLAIN}isAwesome!"

#
# Server host to make request to, 
# you may use a named container of "webhost" instead
#
ENV FORWARD_HOST webhost

# The destination server port
ENV FORWARD_PORT 80

# The forwarding protocall
ENV FORWARD_PROT "http"

# Authentication realm, used by auth_basic (see: http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html)
ENV AUTH_REALM="Restricted"

# Nginx proxy read timed, default is 600 seconds (10 minutes)
ENV PROXY_READ_TIMEOUT 600
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
