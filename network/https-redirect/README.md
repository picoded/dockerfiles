# picoded/https-redirect

https://hub.docker.com/r/picoded/https-redirect/
https://github.com/picoded/dockerfiles/tree/master/network/https-redirect

## Summary and configuration
A simple nginx server, which redirects all its requests from HTTP to HTTPS. 
Useful in enforcing a HTTPS connection =)

It only has a single optional configuration, the HTTP Code to reply with, as documented below.

```
#
# Redirection HTTP code. 
# Use either 307 (default) - Temporary Redirect
# Or 308 - Permanent Redirect
#
ENV HTTPCODE 307
```
