FROM debian:jessie

RUN apt-get -y update && \
	apt-get -y install apt-transport-https curl && \
	curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
	echo "deb https://packages.elastic.co/beats/apt stable main" | tee -a /etc/apt/sources.list.d/beats.list && \
	apt-get -y update && \
	apt-get -y install filebeat && \
	apt-get clean;

# Volumes to mount on host machine (docker, and filebeat registry)
VOLUME /var/lib/docker/containers
VOLUME /var/lib/filebeat

# Log path to read from
ENV LOG_PATH     "/var/lib/docker/containers/*/*.log.*"

# Filebeat db tracker : Required to ensure no log duplicates
# occur within resets / updates of filebeat image
ENV LOG_REGISTRY "/var/lib/filebeat/registry"

# Elasticsearch host to push into
ENV ES_HOST    elasticsearch

# Elasticsearch port to push into
ENV ES_PORT    9200

# Elasticsearch prefix to use
ENV ES_PREFIX  "filebeat"

# Filebeat configuration yml (will load environment configs)
ADD filebeat.yml /etc/filebeat/filebeat.yml

# Entrypoint to run filebeat
ENTRYPOINT ["/usr/bin/filebeat", "-e", "-v", "-c", "/etc/filebeat/filebeat.yml"]