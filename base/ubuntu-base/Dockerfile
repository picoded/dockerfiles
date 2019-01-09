# Ubuntu base image, see README for more details
#
# VERSION               1.0.1
#
FROM ubuntu:16.04

#
# Distribution configuration
#

# Add some core repos
RUN apt-get update && \
	apt-get install -y sudo curl zip openssl build-essential python-software-properties && \
	apt-get clean;
	
# Add nodejs distribution
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo bash - && apt-get update && apt-get clean;

#
# Default environment variables
#

# Default system timezone (Singapore)
ENV TIMEZONE=GMT+08
# Used to configure OS language support
ENV LANGUAGE=en_US.UTF-8
# Commands to execute prior to aptget install/upgrade on bootup
ENV APTGET_PRESCRIPT=""
# Performs the installation of the following if missing on bootup
ENV APTGET_INSTALL=""
# Performs an apt-get upgrade on bootup
ENV APTGET_UPGRADE=false
# Commands to execute after aptget install/upgrade on bootup
ENV APTGET_POSTSCRIPT=""

#
# Core folders setup
#

# Make sure the basic folder is setup, with permission nukes
RUN mkdir /workspace && mkdir /entrypoint && \
	ln -s /workspace /appspace && \
	chmod -R 0777 /workspace && chmod +x /workspace;
	
WORKDIR /workspace
# VOLUME /workspace

#
# Prepares the entrypoint primer script
#
RUN echo '#!/bin/bash'                                                                  > /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo 'echo "###"'                                                                   >> /entrypoint/primer.sh && \
	echo 'echo "### Start of picoded/ubuntu-base : entrypoint/primer.sh"'               >> /entrypoint/primer.sh && \
	echo 'echo "###"'                                                                   >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# Enters the /workspace'                                                      >> /entrypoint/primer.sh && \
	echo 'cd /workspace;'                                                               >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# TIMEZONE run'                                                               >> /entrypoint/primer.sh && \
	echo 'if [ -n "$TIMEZONE" ] ; then'                                                 >> /entrypoint/primer.sh && \
	echo '   echo "### Enforce TIMEZONE config : $TIMEZONE"'                            >> /entrypoint/primer.sh && \
	echo '   TZ="$TIMEZONE";'                                                           >> /entrypoint/primer.sh && \
	echo '   export TZ;'                                                                >> /entrypoint/primer.sh && \
	echo 'fi'                                                                           >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# LANGUAGE run'                                                               >> /entrypoint/primer.sh && \
	echo 'if [ -n "$LANGUAGE" ] ; then'                                                 >> /entrypoint/primer.sh && \
	echo '   echo "### Enforce LANGUAGE config : $LANGUAGE"'                            >> /entrypoint/primer.sh && \
	echo '   locale-gen "$LANGUAGE";'                                                   >> /entrypoint/primer.sh && \
	echo 'fi'                                                                           >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# APTGET_PRESCRIPT run'                                                       >> /entrypoint/primer.sh && \
	echo 'if [ -n "$APTGET_PRESCRIPT" ] ; then'                                         >> /entrypoint/primer.sh && \
	echo '   echo "### Running APTGET_PRESCRIPT"'                                       >> /entrypoint/primer.sh && \
	echo '   eval "$APTGET_PRESCRIPT";'                                                 >> /entrypoint/primer.sh && \
	echo 'fi'                                                                           >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# APTGET_INSTALL run'                                                         >> /entrypoint/primer.sh && \
	echo 'if [ -n "$APTGET_INSTALL" ] ; then'                                           >> /entrypoint/primer.sh && \
	echo '   echo "### Running APTGET_INSTALL"'                                         >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '   APTGET_INSTALL_ARRAY=($APTGET_INSTALL)'                                    >> /entrypoint/primer.sh && \
	echo '   ACTUAL_INSTALL_ARRAY=()'                                                   >> /entrypoint/primer.sh && \
	echo '   for NAME in "${APTGET_INSTALL_ARRAY[@]}"'                                  >> /entrypoint/primer.sh && \
	echo '   do'                                                                        >> /entrypoint/primer.sh && \
	echo '      if [ -z $(which $NAME) ] ; then'                                        >> /entrypoint/primer.sh && \
	echo '         ACTUAL_INSTALL_ARRAY+=($NAME)'                                       >> /entrypoint/primer.sh && \
	echo '      fi'                                                                     >> /entrypoint/primer.sh && \
	echo '   done'                                                                      >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '   if [ "${#ACTUAL_INSTALL_ARRAY[@]}" = 0 ] ; then'                           >> /entrypoint/primer.sh && \
	echo '      echo "### - No additional installation needed"'                         >> /entrypoint/primer.sh && \
	echo '   else'                                                                      >> /entrypoint/primer.sh && \
	echo '      apt-get update;'                                                        >> /entrypoint/primer.sh && \
	echo '      apt-get install -y $APTGET_INSTALL'                                     >> /entrypoint/primer.sh && \
	echo '   fi'                                                                        >> /entrypoint/primer.sh && \
	echo 'fi'                                                                           >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# APTGET_UPGRADE run'                                                         >> /entrypoint/primer.sh && \
	echo 'if [ "$APTGET_UPGRADE" = true ] || [ "$APTGET_UPGRADE" = "true" ] ; then'     >> /entrypoint/primer.sh && \
	echo '   echo "### Running APTGET_UPGRADE"'                                         >> /entrypoint/primer.sh && \
	echo '   apt-get update; apt-get -y upgrade;'                                       >> /entrypoint/primer.sh && \
	echo 'fi'                                                                           >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# APTGET_POSTSCRIPT run'                                                      >> /entrypoint/primer.sh && \
	echo 'if [ -n "$APTGET_POSTSCRIPT" ] ; then'                                        >> /entrypoint/primer.sh && \
	echo '   echo "### Running APTGET_POSTSCRIPT"'                                      >> /entrypoint/primer.sh && \
	echo '   eval "$APTGET_POSTSCRIPT";'                                                >> /entrypoint/primer.sh && \
	echo 'fi'                                                                           >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo 'echo "###"'                                                                   >> /entrypoint/primer.sh && \
	echo 'echo "### Finished picoded/ubuntu-base : entrypoint/primer.sh"'               >> /entrypoint/primer.sh && \
	echo 'echo "###"'                                                                   >> /entrypoint/primer.sh && \
	echo ''                                                                             >> /entrypoint/primer.sh && \
	echo '# Chain the execution commands'                                               >> /entrypoint/primer.sh && \
	echo 'exec "$@"'                                                                    >> /entrypoint/primer.sh && \
	chmod +x /entrypoint/primer.sh;
	
#
# Useful for build debugging
#
# RUN cat /entrypoint/primer.sh;

#
# Runs with entry point and command
#
ENTRYPOINT ["/entrypoint/primer.sh"] 
CMD echo "### hello world : overwrite your actual command here"
