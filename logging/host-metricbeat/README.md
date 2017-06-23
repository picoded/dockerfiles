# picoded/docker-metricbeat

https://hub.docker.com/r/picoded/docker-metricbeat/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-metricbeat/

## Summary

> Getting host stats into elasticsearch (not container stats)

This was designed to work with its sibling `docker-metricbeat`

https://hub.docker.com/r/picoded/docker-metricbeat/  
https://github.com/picoded/dockerfiles/tree/master/logging/docker-metricbeat/  

You will need the following volume mounted, with readonly access.

`/:/hostfs/:ro`

If your uncomfortable giving FULL directory access,
you can reduce it down to the following

`/sys/proc/:/hostfs/proc/:ro`
`/sys/etc/hostname:/hostfs/etc/hostname:ro`
`/sys/fs/cgroup/:/hostfs/sys/fs/cgroup/:ro`

Finally of course, ensured that `elasticsearch` is configured.

## Configuration

``` 
# Interval of capturing metrics
ENV METRIC_PERIOD 1s

# Elasticsearch host to push into
ENV ES_HOST    elasticsearch

# Elasticsearch port to push into
ENV ES_PORT    9200

# Elasticsearch protocall to use
ENV ES_PROT    "http"

# Elasticsearch username to use
ENV ES_USER    elasticsearch

# Elasticsearch password to use
ENV ES_PASS    PleaseChangeThisToActualPassword

# Elasticsearch index to use 
ENV ES_INDEX  "host-metricbeat-%{+yyyy.MM.dd}"
```

## Data collected

Currently this metricbeat is configured to collect the following inside metricbeat.yml
```
  metricsets:
    # CPU stats
    - cpu
    # Per CPU core stats
    - core
    # System Load stats
    - load
    # IO stats
    - diskio
    # Per filesystem stats
    - filesystem
    # File system summary stats
    - fsstat
    # Memory stats
    - memory
    # Network stats
    - network
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
