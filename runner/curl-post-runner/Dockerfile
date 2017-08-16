#
# Simple utility docker, just used to perform a curl POST call
# Probably to call an API as part of the setup process
#
# VERSION               1.0.1
FROM alpine:latest

# Install curl
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

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