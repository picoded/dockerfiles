# tomcat
#
# VERSION               0.0.1
#
# Note this is referenced from : https://github.com/docker-library/tomcat/blob/df283818c14e8f24c294e2d3cd23099ef92e6643/8-jre8/Dockerfile
#
FROM tomcat:8-jre8

ENV CATALINA_HOME /usr/local/tomcat
WORKDIR $CATALINA_HOME
EXPOSE 8080

#
# Does the setup of manager account
#
ENV MANAGER_USER the-manager
ENV MANAGER_PASS needs-a-new-password-here

# Runs with manager user / pass, and start command
CMD echo "<?xml version='1.0' encoding='utf-8'?>\n<tomcat-users>\n<role rolename=\"manager-gui\"/>\n<user username=\"$MANAGER_USER\" password=\"$MANAGER_PASS\" roles=\"manager-gui\"/>\n</tomcat-users>\n" > ./conf/tomcat-users.xml && catalina.sh run