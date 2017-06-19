# Provides a simplified wso2is deployment
#
# VERSION               1.0.0
#
FROM            picoded/ubuntu-oracle-8-jdk
MAINTAINER      Eugene Cheah <eugene@picoded.com>

# Due to the build NOT officially having a public downloadable link (without filling up a form)
# The following is the build URL used as a "mirror" instead, along with the filename
#
# Note that modifying this environment variable on deployment has zero impact
# as the respective file would already be downloaded and installed
#
# Really, all i want is to do fully automated builds.
ENV BUILD_URL "https://github.com/picoded/dockerfiles/raw/WSO2-builds/security/wso2is/wso2is-5.3.0.zip"
ENV BUILD_FILENAME "wso2is-5.3.0.zip"

# Build installation subpath, this is specific to the archive
ENV BUILD_SUBPATH "wso2is-5.3.0"

# Build installation location, this exclude persistant data
ENV BUILD_LOCATION "/wso2is"

# Download the zip file, explodes it, then remove the zip
RUN \
	mkdir -p "$BUILD_LOCATION" && \
	wget "$BUILD_URL" -O "/tmp/$BUILD_FILENAME"

# && \
RUN \
	unzip "/tmp/$BUILD_FILENAME" "$BUILD_SUBPATH/*" -d "$BUILD_LOCATION"

RUN ls "/wso2is";

#&& \
RUN \
	cd "$BUILD_LOCATION/$BUILD_SUBPATH" && \
	mv * ../ && \
	cd .. && \
	rmdir "$BUILD_LOCATION/$BUILD_SUBPATH" && \
	rm "/tmp/$BUILD_FILENAME";

RUN ls "/wso2is";

# Does some configuraton change
# To make system more usable in docker setup
RUN \
	cd "$BUILD_LOCATION/repository/conf" && \
	sed -i "s|<!-- EnableHTTPAdminConsole>true</EnableHTTPAdminConsole -->|<EnableHTTPAdminConsole>true</EnableHTTPAdminConsole>|g" carbon.xml;

# The port this system uses for HTTP, HTTPS, and ldap
EXPOSE 9763 9443 10389

# The actual run command
CMD $BUILD_LOCATION/bin/wso2server.sh;