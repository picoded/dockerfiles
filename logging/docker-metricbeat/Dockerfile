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
#
# NOTE: due to the docker API requiring more then 2 seconds
#       metric period should ATLEAST be 10 seconds to prevent timeouts
# SEE:  https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-module-docker.html
ENV METRIC_PERIOD 1s

# Docker metrics, are polled on a minute basis
# Due to prolification of microservices, this keeps metrics "sane"
ENV DOCKER_METRIC_PERIOD 1m

# File system interval (as fluctuations isnt as large)
# nor critical to be monitoring on short timeframes
ENV FS_METRIC_PERIOD 10m

# Regex to use, on dropping file system from logging
# By default it logs root, and any mdX devices (assuming a storage instance)
ENV FS_DROP_REGEX "^/(?!($|/dev/md.*$))"

# Likewise process metrics are trottled to limit logging size
# This logs both process list, and socket information
# 
# This information is mainly used for detecting malicious process / intrusion 
ENV PROC_METRIC_PERIOD 10m

# Process only top X of CPU / ram processes only. 
ENV PROC_TOP_ENABLE "false"
ENV PROC_CPU_TOP 25
ENV PROC_RAM_TOP 25

# Socket logging, with reverese DNS lookup
ENV SOCKET_REVERSE_LOOKUP "true"

# Enable / disable system monitoring
ENV SYSTEM_ENABLE "true"

# Enable / disable docker conatainer monitoring
ENV DOCKER_ENABLE "true"

# Logging level to output, production should use warning
ENV LOGGING_LEVEL "warning"

####################################################
#
# Actual build and entrypoint
#
####################################################

# Perform setup as root user
USER root

# Install some common modules needed
RUN yum install -y curl vim && yum clean all
# RUN curl -fsSL https://get.docker.com/ | sh && yum clean all
# RUN usermod -aG docker metricbeat

# Copying over the relevent metricbeat configuration
COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml
# RUN chown metricbeat /usr/share/metricbeat/metricbeat.yml

# Revert as metricbeat user
#
# NOTE: We are not reverting due to a user permission issue
# with groups, which can be rather host specific. See 
# https://discuss.elastic.co/t/trouble-running-metricbeat-5-3-0-with-docker-module/82204/6
# for details and possible long term solution
#
# @TODO : Test automated groupid assignment on run solution
#
# USER metricbeat

# Build version check logging (for debugging)
RUN metricbeat --version

# Perform a configration file test
RUN metricbeat -c /usr/share/metricbeat/metricbeat.yml -configtest

# Assumes hostfs metricbeat binding 
# (as that is what this container is for)
ENTRYPOINT ["metricbeat", "-system.hostfs=/hostfs"]