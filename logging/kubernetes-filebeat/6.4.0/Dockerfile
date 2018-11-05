# This uses the offical filebeat version
FROM docker.elastic.co/beats/filebeat:6.4.0

####################################################
#
# Required volumes and network bindings
#
####################################################

# Filebeat folder - used to store data for tracking of changes
VOLUME            /var/lib/filebeat/data/

# Log path to read from docker containers
VOLUME            /var/lib/docker/containers/

####################################################
#
# Environment variable configurations 
#
####################################################

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
ENV ES_INDEX  "filebeat-%{[beat.version]}-%{+yyyy.MM}"

# Elasticsearch template name to use for index setup
ENV ES_TEMPLATE_NAME "filebeat"

# Elasticsearch template pattern to use for index setup
ENV ES_TEMPLATE_PATTERN "filebeat-*"

# Kibana Dashboard index to use 
ENV DASH_INDEX "filebeat-*"

# Compression level of log submissions 0 - 9
# NOTE: This is not supported in AWS Elasticsearch
ENV ES_COMPRESSION 0

# Bulk batch size. This is used in conjuncture with LOG_LINE_MAX
# To ensure that the total BULK request size does not exceed 100MB
ENV ES_BATCHSIZE 20

#-----------------------------------------------
# metricbeat specific settings
#-----------------------------------------------

# Logging level to output, production should use warning
# Possible values : critical, error, warning, info, debug
ENV BEAT_LOGGING_LEVEL "info"

# Metricbeat tags to add
ENV BEAT_TAGS "[]"

# The logging period for metricbeat internal metrics
ENV BEAT_LOGGING_PERIOD "10m"

#-----------------------------------------------
# filebeat settings
#-----------------------------------------------

# A single log line maximum bytes
# 250,000 bytes was selected, so that 20 log lines
# would be under 100MB with some format overhead.
ENV LOG_LINE_MAX 250000

# Logging level to output, production should use warning
ENV BEAT_LOGGING_LEVEL "warning"

# The logging period for metricbeat internal metrics
ENV BEAT_LOGGING_PERIOD "10m"

# Regex rules to filter out lines
# This is useful for extremly noisy containers,
# With little logging value : Such as rancher ipsec-router
#
# These filters were however carefully chosen, to avoid accidentally blocking off
# logs that could have been wanted elsewhere. In most cases that is.
# Modify these filters as you require.
#
# Note that due to the limitation of yml,
# Arrays are not supported =(
#
# So lets give this long regex. A breakdown
#
# ```
# //
# // Start by greadily claiming json prefixes, and wrapping in a multi conditional "array"
# //
# .*(
#      //
#      // Remove the most verbose ipsec, VPN traffic in rancher
#      //
#      ([0-9]{2}\[(KNL|IKE|MGR|NET)\])|
#      //
#      // Remove the succesful Filebeat elastic search submission, reducing a logging loop
#      // Which would potentially be perpetual, if BATCHSIZE is 1
#      //
#      (POST /_bulk HTTP/1.1\" 200 [0-9]* \"-\" \"Go-http-client/1.1)|
#      //
#      // Removing several rancher services logs, but not all
#      // As some are way too vague to safely filter out, without accidentally 
#      // filtering out another application
#      //
#      (level\=debug.*io\.rancher)
# //
# // End by greadily claiming ending char, and closing the multi conditional block
# //
# ).*
# ```
ENV LOG_EXCLUDE_LINE ".*(([0-9]{2}\[(KNL|IKE|MGR|NET)\])|(POST /_bulk HTTP/1.1\" 200 [0-9]* \"-\" \"Go-http-client/1.1)|(level\=debug.*io\.rancher)).*"

####################################################
#
# Actual build and entrypoint
#
####################################################

# Filebeat configuration yml (will load environment configs)
ADD filebeat.yml /etc/filebeat/filebeat.yml

# Build version check
RUN filebeat version

# Entrypoint to run filebeat
ENTRYPOINT ["filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]