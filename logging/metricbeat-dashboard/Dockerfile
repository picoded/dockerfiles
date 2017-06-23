# This uses the offical metricbeat version : 5.4.2
FROM docker.elastic.co/beats/metricbeat:5.4.2

####################################################
#
# Required volumes and network bindings
#
####################################################

####################################################
#
# Environment variable configurations 
#
####################################################

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
ENV ES_PREFIX  "metricbeat-"

####################################################
#
# Actual build and entrypoint
#
####################################################

# Perform setup as root user
USER root

# Copying over the relevent metricbeat configuration
COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml
RUN chown metricbeat /usr/share/metricbeat/metricbeat.yml

# Revert as metricbeat user
USER metricbeat

# Build version check logging
RUN metricbeat --version

# Perform a configration file test
RUN metricbeat -c /usr/share/metricbeat/metricbeat.yml -configtest

# Assumes hostfs metricbeat binding 
# (as that is what this container is for)
ENTRYPOINT ./scripts/import_dashboards -es ${ES_PROT}://${ES_HOST}:${ES_PORT} -user ${ES_USER} -pass ${ES_PASS}