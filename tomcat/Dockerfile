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
CMD echo "<?xml version='1.0' encoding='utf-8'?>" > ./conf/tomcat-users.xml && \
	echo "<tomcat-users xmlns=\"http://tomcat.apache.org/xml\"" >> ./conf/tomcat-users.xml && \
	echo "              xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"" >> ./conf/tomcat-users.xml && \
	echo "              xsi:schemaLocation=\"http://tomcat.apache.org/xml tomcat-users.xsd\"" >> ./conf/tomcat-users.xml && \
	echo "              version=\"1.0\">" >> ./conf/tomcat-users.xml && \
	echo "	<role rolename=\"admin\"/>" >> ./conf/tomcat-users.xml && \
	echo "	<role rolename=\"manager\"/>" >> ./conf/tomcat-users.xml && \
	echo "	<user username=\"$MANAGER_USER\" password=\"$MANAGER_PASS\" roles=\"standard,manager,admin,manager-gui,manager-script\"/>" >> ./conf/tomcat-users.xml && \
	echo "</tomcat-users>" >> ./conf/tomcat-users.xml && \
	./bin/startup.sh run 2> /dev/null && \
	tail -f /dev/null; 