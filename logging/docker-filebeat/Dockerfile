FROM debian:jessie

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

# Regex rules to filter out lines
# This is useful for extremly noisy containers,
# With little logging value : Such as rancher ipsec-router
#
# Note that due to the limitation of yml,
# Arrays are not supported =(
ENV LOG_EXCLUDE_LINE ".*(([0-9]{2}\[(KNL|IKE|MGR|NET)\])|(POST /_bulk HTTP/1.1\" 200 [0-9]* \"-\" \"Go-http-client/1.1)).*"

# A single log line maximum bytes
# 900,000 bytes was selected, so that 10 log lines
# would be under 10MB with some format overhead.
ENV LOG_LINE_MAX 900000

# Elasticsearch host to push into
ENV ES_HOST    elasticsearch

# Elasticsearch port to push into
ENV ES_PORT    9200

# Elasticsearch index to use 
ENV ES_INDEX  "docker-filebeat-%{+yyyy.MM.dd}"

# Compression level of log submissions 0 - 9
# NOTE: This is not supported in AWS Elasticsearch
ENV ES_COMPRESSION 0

# Bulk batch size. This is used in conjuncture with LOG_LINE_MAX
# To ensure that the total BULK request size does not exceed 10MB
ENV ES_BATCHSIZE 10

# Filebeat configuration yml (will load environment configs)
ADD filebeat.yml /etc/filebeat/filebeat.yml

# Build version check
RUN filebeat --version

# Entrypoint to run filebeat
ENTRYPOINT ["/usr/bin/filebeat", "-e", "-v", "-c", "/etc/filebeat/filebeat.yml"]