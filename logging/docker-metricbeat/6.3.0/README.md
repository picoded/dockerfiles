# picoded/docker-metricbeat

https://hub.docker.com/r/picoded/docker-metricbeat/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-metricbeat/

## Summary

> Getting host and container stats into elasticsearch 

This container will need be mounted to host network.
This container will need root access

If you are using rancherOS, or a restricted OS use the following

`/proc/:/hostfs/proc/:ro`
`/sys/fs/cgroup/:/hostfs/sys/fs/cgroup/:ro`
`/etc/hostname:/hostfs/etc/hostname:ro`
`/var/lib/docker/:/var/lib/docker:ro`
`/var/run/docker.sock:/hostfs/var/run/docker.sock:rw`

If your system allows it, you can simplify the above with the following (not fully tested)

`/:/hostfs/:ro`
`/var/run/docker.sock:/hostfs/var/run/docker.sock:rw`

For docker monitoring, ensure the following is mounted


Finally of course, ensured that `elasticsearch` is configured.

## Configuration

``` 
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
ENV ES_INDEX  "metricbeat-%{[beat.version]}-%{+yyyy.MM}"

# Elasticsearch template name to use for index setup
ENV ES_TEMPLATE_NAME "metricbeat"

# Elasticsearch template pattern to use for index setup
ENV ES_TEMPLATE_PATTERN "metricbeat-*"

# Compression level of log submissions 0 - 9
# NOTE: This is not supported in AWS Elasticsearch
ENV ES_COMPRESSION 0

# Bulk batch size. This is used to approximately ensure
# To ensure that the total BULK request size does not exceed 100MB
ENV ES_BATCHSIZE 50
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