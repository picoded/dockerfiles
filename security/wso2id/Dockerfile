# Provides a simplified wso2is deployment
#
# VERSION               1.0.0
#
FROM            picoded/ubuntu-oracle-8-jdk
MAINTAINER      Eugene Cheah <eugene@picoded.com>

# Due to the build NOT officially having a public downloadable link (without filling up a form)
# The following is the build URL used as a "mirror" instead, along with the filename, and its deployment location
#
# Note that modifying this environment variable on deployment has zero impact
# as the respective file would already be downloaded and installed
#
# Really, all i want is to do fully automated builds.
ENV BUILD_URL "https://github.com/picoded/dockerfiles/raw/WSO2-builds/security/wso2is/wso2is-5.3.0.zip"
ENV BUILD_FILENAME "wso2is-5.3.0.zip"
ENV BUILD_LOCATION "/wso2is"

# Download the zip file, explodes it, then remove the zip
RUN \
	mkdir -p "$BUILD_LOCATION" && \
	wget "$BUILD_URL" -O "/tmp/$BUILD_FILENAME"; 
# && \
RUN \
	unzip "/tmp/$BUILD_FILENAME" -d "$BUILD_LOCATION" && \
	rm "/tmp/$BUILD_FILENAME";

RUN ls "/wso2is";

# The actual run command
CMD $BUILD_LOCATION/bin/wso2server.sh;