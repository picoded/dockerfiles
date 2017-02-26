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

# Elasticsearch host to push into
ENV ES_HOST    elasticsearch

# Elasticsearch port to push into
ENV ES_PORT    9200

# Elasticsearch prefix to use 
ENV ES_PREFIX  "filebeat-%{+yyyy.MM.dd}"

# Compression level of log submissions 1 - 9
ENV ES_COMPRESSION 2

# Filebeat configuration yml (will load environment configs)
ADD filebeat.yml /etc/filebeat/filebeat.yml

# Build version check
RUN filebeat --version

# Entrypoint to run filebeat
ENTRYPOINT ["/usr/bin/filebeat", "-e", "-v", "-c", "/etc/filebeat/filebeat.yml"]