# clones a git repo,
# do whatever you want with it with a script
#
# Now with Go! lang
#
# VERSION               1.0.1
#
FROM picoded/git-cloner-base:latest

# This is in accordance to : https://hub.docker.com/r/partlab/ubuntu-golang/~/dockerfile/
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8
ENV GOVERSION 1.6
ENV GOROOT /opt/go
ENV GOPATH /root/.go

RUN apt-get update; apt-get install -y wget;
RUN cd /opt && wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz && \
    tar zxf go${GOVERSION}.linux-amd64.tar.gz && rm go${GOVERSION}.linux-amd64.tar.gz && \
    ln -s /opt/go/bin/go /usr/bin/ && \
    mkdir $GOPATH

# Installing the godep
# Excluded, run this after the git clone
# RUN go get github.com/tools/godep;