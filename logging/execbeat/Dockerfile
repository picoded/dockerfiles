# Executes a command, and pushes it to elasticsearch
#
# VERSION               1.0.1
#
FROM picoded/ubuntu-base

####################################################
#
# execbeat installation
#
####################################################

# Docker execbeat build install
RUN apt-get -y update && \
	apt-get -y install sudo apt-utils apt-transport-https curl && \
	curl -L -O https://github.com/christiangalsterer/execbeat/releases/download/3.3.0/execbeat-3.3.0-amd64.deb && \
	sudo dpkg -i execbeat-3.3.0-amd64.deb && \
	rm -f execbeat-3.3.0-amd64.deb;

####################################################
#
# Environment variable configurations 
#
####################################################

#-----------------------------------------------
# Execbeat settings
#-----------------------------------------------

# The execution command, without arguments
ENV EX_CMD     "date"

# The parameters to pass the command, note that this assume that spaces, 
# are a seperate param, without the quotes. For example.
#
# ENV_PARAMS="argA argB argC"
#
# Refrence: https://github.com/christiangalsterer/execbeat/issues/7
#
# Unfortunately this crashes / fail if its completely blank
# So ensure that atleast a " " blank string of one space is used
ENV EX_PARAMS  " "

# The excution frequency
ENV EX_CRON "@every 60s"

# The execbeat document type
ENV EX_DOC_TYPE "date"

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
ENV ES_INDEX  "execbeat-%{+yyyy.MM}"

# Logging level to output, production should use warning
ENV LOGGING_LEVEL "warning"

####################################################
#
# config, run and entrypoint
#
####################################################

# Execbeat configuration yml (will load environment configs)
ADD execbeat.yml /etc/execbeat/execbeat.yml

# Permission settings requried for execbeat.yml
RUN sudo chmod go-w /etc/execbeat/execbeat.yml

# Test the current configuration settings for validity
RUN /usr/share/execbeat/bin/execbeat -configtest -path.config=/etc/execbeat/

# Version check for easy debug in docker build
RUN /usr/share/execbeat/bin/execbeat -version

# The final execution
ENTRYPOINT [ "/entrypoint/primer.sh", "/usr/share/execbeat/bin/execbeat" ]
CMD [ "-v", "-e", "-path.config=/etc/execbeat/" ]