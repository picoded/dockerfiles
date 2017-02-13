# picoded/jenkins-slave 

Extended from `ubuntu-base:latest` official repo

Jenkins slave client for a Jenkins server.

## jenkins-slave environment variables

Critical Jenkins environment variables needed by the slave.

+ `JENKINS_HOST=https://builds.apache.org` : Docker server host URL
+ `JENKINS_SLAVE_NAME=docker-slave` : Docker slave name
+ `JENKINS_SLAVE_SECRET=super-not-so-secure-token` : Docker slave secret token

Optional Jenkins environment variable

+ `JAVA_OPTS` : Java runtime options
+ `JENKINS_OPTS` : Additional Jenkins options string
+ `JENKINS_PRESCRIPT` : Shell script to run before running jenkins
+ `JENKINS_CONNECTION` : The `-connectTo` option configuration. Used for overwriting connection paths.

## openjdk-8-jdk environment variables

+ `JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/` : Java home location

## Standard environment variables

+ `TIMEZONE=GMT+08` : Default system timezone (Singapore)
+ `LANGUAGE=en_US.UTF-8` : Used to configure OS language support
+ `APTGET_PRESCRIPT=""` : Commands to execute prior to aptget install/upgrade on bootup
+ `APTGET_INSTALL=""` : Performs the installation of the following if missing on bootup
+ `APTGET_UPGRADE=false` : Performs an apt-get upgrade on bootup
+ `APTGET_POSTSCRIPT=""` : Commands to execute after aptget install/upgrade on bootup

See [base/README](https://github.com/picoded/dockerfiles/tree/master/base) for more details.

## Standard volume mount point

+ `/workspace` : Contains all the various persistent files related to the image

See [base/README](https://github.com/picoded/dockerfiles/tree/master/base) for more details.

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
