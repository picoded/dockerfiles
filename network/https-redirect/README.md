# picoded/https-redirect

https://hub.docker.com/r/picoded/https-redirect/
https://github.com/picoded/dockerfiles/tree/master/network/https-redirect

## Summary and configuration
A simple nginx server, which redirects all its requests from HTTP to HTTPS. 
Useful in enforcing a HTTPS connection =)

It has two optional configurations, the HTTP Code to reply with, and the port to redirect to, as documented below.

``` 
#
# Redirection HTTP code. 
# Use either 307 (default) - Temporary Redirect
# Or 308 - Permanent Redirect
#
ENV HTTPCODE 307

# HTTPS port to redirect to, by default 443
ENV TARGET_PORT 443
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
