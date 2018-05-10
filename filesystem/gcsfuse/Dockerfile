#
# gcsfuse : Google cloud storage, as a mounted volume!
#
# VERSION                   1.0.0
#

#
# Compiling GCStorage from github
#
FROM golang:1.10.0-alpine as gocompile
RUN apk add --no-cache git
ENV GOPATH /go
RUN go get -u github.com/googlecloudplatform/gcsfuse

#
# Build the actual container
#
FROM alpine:3.7

# Install fuse (requirement)
RUN apk add --no-cache ca-certificates fuse && rm -rf /tmp/*
RUN apk add --no-cache ca-certificates bash && rm -rf /tmp/*

# Copy over built package
COPY --from=gocompile /go/bin/gcsfuse /usr/local/bin
RUN mkdir -p /workspace
WORKDIR /workspace

# Setup environment variables
ENV GOOGLE_APPLICATION_CREDENTIALS="/gcscredentials"

# Credential file to use and write,
# note that this is ignored if the credential file already exists
ENV GOOGLE_APPLICATION_CREDENTIALS_JSON=""

# Mount point for the gcs file system
ENV GCSFUSE_MOUNT="/workspace"

# Bucket name to mount
ENV GCSFUSE_BUCKET=""

# GCSFUSE arguments to use
# See : https://github.com/GoogleCloudPlatform/gcsfuse
ENV GCSFUSE_ARGS="--limit-ops-per-sec 100 --limit-bytes-per-sec 100 --stat-cache-ttl 60s --type-cache-ttl 60s"

#
# Setup any of the GCS credential json, if found
#
RUN mkdir -p /entrypoint/ && \
	echo '#!/bin/bash' > /entrypoint/gcsfuse.sh && \
	echo ''                                                              >> /entrypoint/gcsfuse.sh && \
	echo '# Configuration checks'                                        >> /entrypoint/gcsfuse.sh && \
	echo 'if [ -z "${GCSFUSE_BUCKET}" ]; then'                           >> /entrypoint/gcsfuse.sh && \
	echo '    echo "Error: GCSFUSE_BUCKET is not specified"'             >> /entrypoint/gcsfuse.sh && \
	echo '    exit 128'                                                  >> /entrypoint/gcsfuse.sh && \
	echo 'fi'                                                            >> /entrypoint/gcsfuse.sh && \
	echo ''                                                              >> /entrypoint/gcsfuse.sh && \
	echo '# Write auth file if it does not exist'                        >> /entrypoint/gcsfuse.sh && \
	echo 'if [ ! -f "${GOOGLE_APPLICATION_CREDENTIALS}" ]; then'         >> /entrypoint/gcsfuse.sh && \
	echo '    if [ -z "${GOOGLE_APPLICATION_CREDENTIALS_JSON}" ]; then'  >> /entrypoint/gcsfuse.sh && \
	echo '        echo "Error: Missing GOOGLE_APPLICATION_CREDENTIALS_JSON or ${GOOGLE_APPLICATION_CREDENTIALS} not provided"'  >> /entrypoint/gcsfuse.sh && \
	echo '        exit 128'                                              >> /entrypoint/gcsfuse.sh && \
	echo '    fi'                                                        >> /entrypoint/gcsfuse.sh && \
	echo '    echo "${GOOGLE_APPLICATION_CREDENTIALS_JSON}" > ${GOOGLE_APPLICATION_CREDENTIALS}'  >> /entrypoint/gcsfuse.sh && \
	echo 'fi'                                                            >> /entrypoint/gcsfuse.sh && \
	echo ''                                                              >> /entrypoint/gcsfuse.sh && \
	echo 'echo "==> [picoded/gcsfuse] : Mounting GCS Filesystem"'        >> /entrypoint/gcsfuse.sh && \
	echo 'mkdir -p ${GCSFUSE_MOUNT}'                                     >> /entrypoint/gcsfuse.sh && \
	echo 'gcsfuse $GCSFUSE_ARGS ${GCSFUSE_BUCKET} ${GCSFUSE_MOUNT}'      >> /entrypoint/gcsfuse.sh && \
	echo ''                                                              >> /entrypoint/gcsfuse.sh && \
	echo 'echo "==> [picoded/gcsfuse] : Entrypoint Chain"'               >> /entrypoint/gcsfuse.sh && \
	echo 'exec "$@"'                                                     >> /entrypoint/gcsfuse.sh && \
	chmod +x /entrypoint/gcsfuse.sh;

# Chain up the entrypoints
ENTRYPOINT [ "/entrypoint/gcsfuse.sh" ]