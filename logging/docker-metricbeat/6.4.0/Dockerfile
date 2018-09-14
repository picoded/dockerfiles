# This uses the offical metricbeat version
FROM docker.elastic.co/beats/metricbeat:6.4.0

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

#-----------------------------------------------
# Running processes metrics
# (Seperate from docker)
#-----------------------------------------------

#
# Settings for controlling the logging of
# server processes. Useful for catching rogue
# processes (infinite sleep or malicious)
#

# Process only top X of CPU / ram processes only. 
ENV PROC_ENABLE "true"

# Top N processes by CPU or RAM to log
ENV PROC_CPU_TOP 25
ENV PROC_RAM_TOP 25

#
# Logging frequency
#
# Due to the size of this dataset, it is highly recommended 
# to never go below a minute-by-minute period
#
ENV PROC_METRIC_PERIOD 30m

#-----------------------------------------------
# Network socket metrics
# (Seperate from docker)
#-----------------------------------------------

# Socket connection monitoring
ENV SOCKET_ENABLE "true"

# Socket logging, with reverese DNS lookup, and its TTL
ENV SOCKET_REVERSE_LOOKUP "true"
ENV SOCKET_REVERSE_TTL "60s"

#
# Logging frequency
#
# Due to the size of this dataset, it is highly recommended 
# to never go below a minute-by-minute period
#
ENV SOCKET_METRIC_PERIOD 30m

#-----------------------------------------------
# System metrics
#-----------------------------------------------

#
# Logging of server system level metrics (not docker)
# Covering the following
#
# - cpu / core / load 
# - diskio
# - memory
# - network
#
# Confusingly does not cover
#
# - Filesystem usage
#

# Enable / disable system monitoring
ENV SYSTEM_ENABLE "true"

# System metrics period
ENV SYSTEM_METRIC_PERIOD 10s

#-----------------------------------------------
# File System metrics
#-----------------------------------------------

#
# Logging of server system Filesystem usage
# note if you do kubernetes mounts,
# it may not appear under here
#

# Enable / disable system monitoring
ENV FS_ENABLE "true"

# File system interval (as fluctuations isnt as large)
# nor critical to be monitoring on short timeframes
ENV FS_METRIC_PERIOD 10m

# # Regex to use, to filter for file systems, and to drop file systems
# # from metric measurment. In event that for, and drop overlap. For takes priority.
# #
# # For example, 
# # if regex matches FS_FOR_REGEX only, the filesystem is monitored
# # if regex matches FS_DROP_REGEX but not FS_FOR_REGEX, the file system is not monitored
# # if regex matches FS_DROP_REGEX and FS_FORE_REGEX, the file system is monitored
# #
# # The default setting monitor the "/" root filesystem, and 
# # any file system (assuming a raid array) following the "/dev/mdX" convention.
# # All other file systems are ignored.
# #
# # (Note: currently dropped, till actual functionality is fixed)
# ENV FS_FOR_REGEX "^(/|/dev/md.*)$"
# ENV FS_DROP_REGEX "^.*$"

#-----------------------------------------------
# Docker metrics
#-----------------------------------------------

#
# Logging of docker container specific metrics
# Covering the following
#
# + container
# + cpu
# + diskio
# + healthcheck
# + info
# + memory
# + network
#

# Enable / disable docker conatainer monitoring
# Default : false (because you might want to use kubernetes metrics instead)
ENV DOCKER_ENABLE "false"

# Docker metrics, are polled on a 10 minute basis by default
#
# Due to the potential size of this dataset, and the timeout involves 
# for the docker api call : it is highly recommended to never go 
# below a minute-by-minute period
ENV DOCKER_METRIC_PERIOD 10m

#-----------------------------------------------
# Kublet metrics
#-----------------------------------------------

#
# Logging of kubernetes container container specific metrics
# Covering the following
#
# + node
# + system
# + pod
# + container
# + volume
#
# Does not cover
# + events
# + state_*
#
ENV KUBLET_METRIC_ENABLE "false"

# Kubernetes metrics interval
ENV KUBLET_METRIC_PERIOD 10m

#
# The kubernetes local metric endpoint
# to use this as "localhost:10255", the metricbeat
# should be running using hostnetworking
#
ENV KUBLET_METRIC_HOST   "localhost:10255"

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
RUN metricbeat version

# Perform a configration file test
RUN metricbeat -c /usr/share/metricbeat/metricbeat.yml test config

# Assumes hostfs metricbeat binding 
# (as that is what this container is for)
ENTRYPOINT ["metricbeat"]
CMD [ "-e", "-system.hostfs=/hostfs"]
