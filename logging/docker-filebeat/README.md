# picoded/docker-filebeat

https://hub.docker.com/r/picoded/docker-filebeat/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-filebeat/

## Summary

> Pushing of normalised docker logs, to elasticsearch

This will require docker-logrotate  
https://hub.docker.com/r/picoded/docker-logrotate/  
https://github.com/picoded/dockerfiles/tree/master/logging/docker-logrotate/  

You will need the following volume mounted, with read/write access.  
`/var/lib/docker/containers/:/var/lib/docker/containers/:rw`  
`/var/lib/filebeat/:/var/lib/filebeat/:rw`  

And of course `elasticsearch` configured.

Note that the default setting works with logrotate,
After the data been "COPYTRUNCATE"-ed away.

Meaning there is a +/- 5 minutes delay between log write, to rotation, to shipping.

## Configuration

``` 
# Log path to read from docker containers
ENV LOG_PATH     "/var/lib/docker/containers/*/*.log.*"

# Elasticsearch host to push into
ENV ES_HOST    elasticsearch

# Elasticsearch port to push into
ENV ES_PORT    9200

# Elasticsearch prefix to use (-{DATE} is auto appended)
ENV ES_PREFIX  "filebeat"
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
