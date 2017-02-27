# picoded/docker-filebeat

https://hub.docker.com/r/picoded/docker-filebeat/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-filebeat/

## Summary

> Pushing of normalised docker logs, to elasticsearch

This was designed to work with logrotate for long term usage.

https://hub.docker.com/r/picoded/docker-logrotate/  
https://github.com/picoded/dockerfiles/tree/master/logging/docker-logrotate/  

You will need the following volume mounted, with read/write access.  
`/var/lib/docker/containers/:/var/lib/docker/containers/:rw`  
`/var/lib/filebeat/:/var/lib/filebeat/:rw`  

And of course `elasticsearch` configured.

Note this is not designed for 0 second realtime log pushes.
(Beside you cant search so in Elasticsearch).

## Configuration

``` 
# Log path to read from docker containers
ENV LOG_PATH     "/var/lib/docker/containers/*/*-json.log"

# Array of Regex rules to filter out lines
# This is useful for extremly noisy containers,
# With little logging value : Such as rancher ipsec-router
ENV LOG_EXCLUDE_LINES '[".*[0-9]{2}\[KNL\].*"]'

# A single log line maximum bytes
# 900,000 bytes was selected, so that 10 log lines
# would be under 10MB with some format overhead.
ENV LOG_LINE_MAX 900000

# Elasticsearch host to push into
ENV ES_HOST    elasticsearch

# Elasticsearch port to push into
ENV ES_PORT    9200

# Elasticsearch index to use 
ENV ES_INDEX  "docker-filebeat-%{+yyyy.MM.dd}"

# Compression level of log submissions 0 - 9
# NOTE: This is not supported in AWS Elasticsearch
ENV ES_COMPRESSION 0

# Bulk batch size. This is used in conjuncture with LOG_LINE_MAX
# To ensure that the total BULK request size does not exceed 10MB
ENV ES_BATCHSIZE 10
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
