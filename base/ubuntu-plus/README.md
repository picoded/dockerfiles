# picoded/ubuntu-openjdk-8-jdk

https://hub.docker.com/r/picoded/ubuntu-openjdk-8-jdk/
https://github.com/picoded/dockerfiles/tree/master/base/ubuntu-openjdk-8-jdk

Represents the base package for many other Docker images, normalised to conform to our requirements as outlined
inside the [base/README](https://github.com/picoded/dockerfiles/tree/master/base), read it up for more details.

## Legacy note

For the approximately 1k pulls for ubuntu 14.04, you can access it still under `picoded/ubuntu-openjdk-8-jdk:14.04`

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
