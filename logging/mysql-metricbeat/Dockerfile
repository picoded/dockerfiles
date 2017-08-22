# This uses the offical metricbeat version : 5.5.1
FROM docker.elastic.co/beats/metricbeat:5.5.1

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
ENV METRIC_PERIOD 1s

# MYSQL data source name (path), this follows the
# mysql module syntax format of [username[:password]@][protocol[(address)]]/
# See: https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-module-mysql.html
ENV MYSQL_DSN "root:secret@tcp(mysqldb:3306)/"

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

# Metricbeat binding 
# (as that is what this container is for)
ENTRYPOINT ["metricbeat"]