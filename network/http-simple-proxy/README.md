# picoded/http-simple-proxy

https://hub.docker.com/r/picoded/http-simple-proxy/
https://github.com/picoded/dockerfiles/tree/master/network/http-simple-proxy

## Summary and configuration
A simple nginx server, which proxy another endpoint.

Environment configuration is as followed in the Dockerfile.

Dun forget to setup your server as a named service at `webhost`
And the password of course at `HTPASSWD`

``` 
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
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
