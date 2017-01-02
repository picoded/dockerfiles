# picoded/http-simple-auth

https://hub.docker.com/r/picoded/http-simple-auth/
https://github.com/picoded/dockerfiles/tree/master/network/http-simple-auth

## Summary and configuration
A simple nginx server, which provides HTTP authentication.

Configuration is as followed in the Dockerfile

``` 
#
# Redirection HTTP code. 
# Use either 307 (default) - Temporary Redirect
# Or 308 - Permanent Redirect
#
ENV HTTPCODE 307
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
