# picoded/curl-post-runner

https://hub.docker.com/r/picoded/curl-post-runner/
https://github.com/picoded/dockerfiles/tree/master/network/curl-post-runner

## Summary and configuration
Takes params, and spits out a curl request.

Use it to ping your API endpoint on docker container setup / etc.

``` 
#
# Curl url, type, and data configuration
#

# URL to send the post request, using this default for easy testing / debugging =)
ENV CURL_URL "https://postman-echo.com/post"

# The data to post over
ENV CURL_DATA "hello=world"

# Common alternative is to use : Content-Type: application/json
# By default data is transmitted as a urlencoded form
ENV CURL_DATATYPE "application/x-www-form-urlencoded"

#
# The running entrypoint
#
ENTRYPOINT curl -H "Content-Type: $CURL_DATATYPE" -X POST -d "$CURL_DATA" "$CURL_URL"
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
