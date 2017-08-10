# This uses the offical metricbeat version : 5.5.1
FROM docker.elastic.co/beats/metricbeat:5.5.1

####################################################
#
# Required volumes and network bindings
#
####################################################

# Metricbeat required host mount volumes
VOLUME /hostfs/proc;
VOLUME /hostfs/sys/fs/cgroup;
VOLUME /hostfs;

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
ENV ES_INDEX  "metricbeat-%{+yyyy.MM.dd}"

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
ENTRYPOINT ["metricbeat", "-system.hostfs=/hostfs"]