# picoded/mysql-runner

https://hub.docker.com/r/picoded/mysql-runner/
https://github.com/picoded/dockerfiles/tree/master/network/mysql-runner

## Summary and configuration
A simple container, used to run a single mysql query.

Normally this is used to run setup commands, that are required once, and can be safely called multiple times. As part of a larger docker template.

Common examples, include user or database setup.

``` 
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
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
