# ubuntu-openjdk-8-tomcat
#
# VERSION               8.0.28
#
# Setsup and configure ubuntu, with openjdk 8, and tomcat 8
#
FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <picoded@socialoctet.com>

# update, and get dependency (wget)
RUN apt-get update && apt-get install -y wget

# install git and coding core utils
RUN mkdir /workspace

# download and unzip the tomcat package, and rename it as tomcat
RUN cd /workspace &&  \
	wget http://www.eu.apache.org/dist/tomcat/tomcat-8/v8.0.28/bin/apache-tomcat-8.0.28.tar.gz && \
	tar xvzf apache-tomcat-8.0.28.tar.gz && \
	mv apache-tomcat-8.0.28 ./tomcat

# Setup workdir
WORKDIR /workspace/tomcat

# Expose port 8080
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