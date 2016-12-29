# picoded/git-cloner-base

https://hub.docker.com/r/picoded/git-cloner-base/
https://github.com/picoded/dockerfiles/tree/master/git-cloner/git-cloner-base

Clones a repository, do whatever you want with it. If you are intending of using this with 
openjdk, or nodejs, you may want to refer to [git-cloner-plus](https://hub.docker.com/r/picoded/git-cloner-plus/) instead

## Environment variables

+ `GIT_REPO="https://user:pass@github.com/picoded/dockerfiles.git"` : Git repo to clone from
+ `GIT_COMMIT="master"` : Branch or commit hash to checkout from
+ `GIT_FOLDER="."` : relative folder to clone into, default is "/workspace/./", do not use blank
+ `GIT_PRESCRIPT=""` : This is the run script, called before git clone/pull
+ `GIT_POSTSCRIPT=""` : This is the run script, called after git clone/pull

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
