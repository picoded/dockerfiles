# picoded/mysql-metricbeat

https://hub.docker.com/r/picoded/mysql-metricbeat/
https://github.com/picoded/dockerfiles/tree/master/logging/mysql-metricbeat/

## Summary

> Get MYSQL metrics, into elasticsearch : For nice fancy dashboards

## Configuration

``` 
#-----------------------------------------------
# Elasticsearch settings
#-----------------------------------------------

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
ENV ES_INDEX  "metricbeat-%{+yyyy.MM.dd}"

#-----------------------------------------------
# metricbeat settings
#-----------------------------------------------

# Interval of capturing metrics
ENV METRIC_PERIOD 1s

# MYSQL data source name (path), this follows the
# mysql module syntax format of [username[:password]@][protocol[(address)]]/
# See: https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-module-mysql.html
ENV MYSQL_DSN "root:secret@tcp(mysqldb:3306)/"

# Logging level to output, production should use warning
ENV LOGGING_LEVEL "warning"
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
