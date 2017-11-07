# picoded/execbeat

https://hub.docker.com/r/picoded/execbeat/
https://github.com/picoded/dockerfiles/tree/master/logging/execbeat/

## Summary

> Execute a command, push its result to elasticsearch

## Configuration

``` 
#-----------------------------------------------
# Execbeat settings
#-----------------------------------------------

# The execution command, without arguments
ENV EX_CMD     "date"

# The parameters to pass the command, note that this assume that spaces, 
# are a seperate param, without the quotes. For example.
#
# ENV_PARAMS="argA argB argC"
#
# Refrence: https://github.com/christiangalsterer/execbeat/issues/7
#
# Unfortunately this crashes / fail if its completely blank
# So ensure that atleast a " " blank string of one space is used
ENV EX_PARAMS  " "

# The excution frequency
ENV EX_CRON "@every 60s"

# The execbeat document type
ENV EX_DOC_TYPE "execbeat"

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
ENV ES_INDEX  "execbeat-%{+yyyy.MM.dd}"

# Logging level to output, production should use warning
ENV LOGGING_LEVEL "warning"
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
