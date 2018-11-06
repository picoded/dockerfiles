# This uses the offical metricbeat version
FROM docker.elastic.co/beats/metricbeat:6.4.0

####################################################
#
# Required volumes and network bindings
#
####################################################

# # Metricbeat required host mount volumes
# VOLUME /hostfs/proc
# VOLUME /hostfs/sys/fs/cgroup
# VOLUME /hostfs

# Note that you will need to bind the network to host
# aka : --net=host
# 
# to properly get the host network metric,
# due to the network interface limitations
# see: https://www.elastic.co/guide/en/beats/metricbeat/current/running-on-docker.html

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

####################################################
#
# Actual build and entrypoint
#
####################################################

# Copying over the relevent metricbeat configuration
COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml

# Build version check logging (for debugging)
RUN metricbeat version

# Perform a configration file test
RUN metricbeat -c /usr/share/metricbeat/metricbeat.yml test config

# Assumes hostfs metricbeat binding 
# (as that is what this container is for)
ENTRYPOINT ["metricbeat"]
CMD [ "-e", "-system.hostfs=/hostfs" ]
