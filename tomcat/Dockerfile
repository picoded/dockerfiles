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

#
# Set the upload size maximum (100mb default)
#
ENV UPLOAD_MAX 100000000
ENV PRE_SCRIPT ""

#
# Reset the manager/html context limation to allow external IP access
# AKA : /usr/local/tomcat/webapps/manager/META-INF/context.xml
#
RUN \
	cd /usr/local/tomcat/webapps/manager/META-INF/ && \
	echo '<?xml version="1.0" encoding="UTF-8"?>' > context.xml && \
	echo '<Context antiResourceLocking="false" privileged="true" >' >> context.xml && \
	echo '</Context>' >> context.xml;

#
# Runs with manager user / pass, and start command
#
CMD sed -i -e "s/<Connector port=\"8080\" protocol=\"HTTP\/1\.1\"[^\n]*/<Connector port=\"8080\" protocol=\"HTTP\/1\.1\" maxPostSize=\"$UPLOAD_MAX\"/g" ./conf/server.xml && \
	sed -i -e "s/<max-file-size>[0-9]*<\/max-file-size>/<max-file-size>$UPLOAD_MAX<\/max-file-size>/g" ./webapps/manager/WEB-INF/web.xml && \
	sed -i -e "s/<max-request-size>[0-9]*<\/max-request-size>/<max-request-size>$UPLOAD_MAX<\/max-request-size>/g" ./webapps/manager/WEB-INF/web.xml && \
	echo "<?xml version='1.0' encoding='utf-8'?>" > ./conf/tomcat-users.xml && \
	echo "<tomcat-users xmlns=\"http://tomcat.apache.org/xml\"" >> ./conf/tomcat-users.xml && \
	echo "              xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"" >> ./conf/tomcat-users.xml && \
	echo "              xsi:schemaLocation=\"http://tomcat.apache.org/xml tomcat-users.xsd\"" >> ./conf/tomcat-users.xml && \
	echo "              version=\"1.0\">" >> ./conf/tomcat-users.xml && \
	echo "	<role rolename=\"admin\"/>" >> ./conf/tomcat-users.xml && \
	echo "	<role rolename=\"manager\"/>" >> ./conf/tomcat-users.xml && \
	echo "	<role rolename=\"manager-gui\"/>" >> ./conf/tomcat-users.xml && \
	echo "	<role rolename=\"manager-script\"/>" >> ./conf/tomcat-users.xml && \
	echo "	<user username=\"$MANAGER_USER\" password=\"$MANAGER_PASS\" roles=\"standard,manager,admin,manager-gui,manager-script\"/>" >> ./conf/tomcat-users.xml && \
	echo "</tomcat-users>" >> ./conf/tomcat-users.xml && \
	echo "#!/bin/bash" > ./prescript.sh && \
	echo "${PRE_SCRIPT}" >> ./prescript.sh && \
	chmod +x ./prescript.sh && \
	./prescript.sh && ./bin/catalina.sh run;
