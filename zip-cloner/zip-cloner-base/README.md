# picoded/zip-cloner-base

https://hub.docker.com/r/picoded/zip-cloner-base/
https://github.com/picoded/dockerfiles/tree/master/zip-cloner/zip-cloner-base

Download a zip file, unpack it, and do whatever you want with it! If you are intending of using this with 
openjdk, or nodejs, you may want to refer to [zip-cloner-plus](https://hub.docker.com/r/picoded/zip-cloner-plus/) instead

## Environment variables

+ `ZIP_URL="https://github.com/picoded/dockerfiles/archive/master.zip"` : Zip URL to download from
+ `ZIP_FILE="master.zip"` : Zip file name to use
+ `ZIP_FOLDER="."` : relative folder to clone into, default is "/workspace/./", do not use blank
+ `ZIP_PRESCRIPT=""` : This is the run script, called before zip download command
+ `ZIP_POSTSCRIPT=""` : This is the run script, called after zip download command

# Inherited from picoded/ubuntu-base

Extension of [picoded/ubuntu-base](https://hub.docker.com/r/picoded/ubuntu-base/), 
where it inherits the standard template from

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
