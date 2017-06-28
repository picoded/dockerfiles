FROM debian:jessie

# @TODO : Migrate to filebeat offical image : See docker-metricbeat for example updated image

#
# Sadly this broke, so till it is "fixed". Its commented out
#
# RUN apt-get -y update && \
# 	apt-get -y install sudo apt-utils apt-transport-https curl && \
# 	curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
# 	echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list && \
# 	apt-get -y update && \
# 	apt-get -y install filebeat && \
# 	apt-get clean;

RUN apt-get -y update && \
	apt-get -y install sudo apt-utils apt-transport-https curl && \
	curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.2.1-amd64.deb && \
	sudo dpkg -i filebeat-5.2.1-amd64.deb && \
	rm -f filebeat-5.2.1-amd64.deb;

# I know this setup was intentional
# https://www.elastic.co/guide/en/beats/libbeat/current/breaking-changes-5.0.html
#
# But really, i prefer having my entrypoint paths working
RUN mv /usr/bin/filebeat.sh /usr/bin/filebeat 2>/dev/null

# Filebeat db tracker : Required to ensure no log duplicates
# occur within resets / updates of filebeat image
ENV LOG_REGISTRY "/var/lib/filebeat/registry"
VOLUME            /var/lib/filebeat

# Log path to read from docker containers
ENV LOG_PATH     "/var/lib/docker/containers/*/*-json.log"
VOLUME            /var/lib/docker/containers

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
ENV ES_INDEX  "docker-filebeat-%{+yyyy.MM.dd}"

# Compression level of log submissions 0 - 9
# NOTE: This is not supported in AWS Elasticsearch
ENV ES_COMPRESSION 0

#-----------------------------------------------
# filebeat settings
#-----------------------------------------------

# Bulk batch size. This is used in conjuncture with LOG_LINE_MAX
# To ensure that the total BULK request size does not exceed 100MB
ENV ES_BATCHSIZE 20

# A single log line maximum bytes
# 250,000 bytes was selected, so that 20 log lines
# would be under 100MB with some format overhead.
ENV LOG_LINE_MAX 250000

# Logging level to output, production should use warning
ENV LOGGING_LEVEL "warning"

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

# Filebeat configuration yml (will load environment configs)
ADD filebeat.yml /etc/filebeat/filebeat.yml

# Build version check
RUN filebeat --version

# Entrypoint to run filebeat
ENTRYPOINT ["/usr/bin/filebeat", "-e", "-v", "-c", "/etc/filebeat/filebeat.yml"]