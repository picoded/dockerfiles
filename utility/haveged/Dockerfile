# Provide entropy (haveged) to the host machine (when run as privileged)
#
# VERSION               1.0.1
#
FROM ubuntu:16.04

# Install haveged
RUN export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -yq rng-tools haveged && \
	apt-get clean;

# Runs haveged
ENTRYPOINT ["haveged"]
CMD ["-F"]
