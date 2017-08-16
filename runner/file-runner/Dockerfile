#
# Simple utility docker, just used to write single file
# Probably to be mounted to another container as a config
#
# VERSION               1.0.1
FROM alpine:latest

#
# File directory, name, and content configurations
#
ENV FILE_DIR "/workspace/"
ENV FILE_NAME "config.json"
ENV FILE_DATA "{ }"

#
# The running entrypoint
#
ENTRYPOINT mkdir -p "$FILE_DIR" && cd "$FILE_DIR" && echo "$FILE_DATA" > "$FILE_NAME"; 