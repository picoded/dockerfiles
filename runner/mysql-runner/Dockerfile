#
# Utility docker, preloaded with mysql-client
# Used to run a single mysql script. Possibly to help setup something
#
# VERSION               1.0.1
FROM alpine:latest

#
# Install docker client
#
RUN apk add --no-cache mysql-client;

#
# Mysql connection configurations
#
ENV MYSQL_DATABASE "SomeDatabase"
ENV MYSQL_USER "root"
ENV MYSQL_PASS "PleaseChangeThisPassword"
ENV MYSQL_HOST "mysqldb"
ENV MYSQL_CONFIG "--default-character-set=utf8mb4 "

#
# Mysql script to run
#
ENV MYSQL_SCRIPT "SHOW TABLES"

#
# The running entrypoint
#
ENTRYPOINT echo "$MYSQL_SCRIPT" | mysql -h $MYSQL_HOST -u $MYSQL_USER --password=$MYSQL_PASS $MYSQL_CONFIG --database $MYSQL_DATABASE