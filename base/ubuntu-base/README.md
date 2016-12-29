# picoded/ubuntu-base

Represents the base package for man other Docker images, normalize to conform to our requirements as outlined
inside the `base/README.md`, read it up for more details.

## Standard environment variables

+ `TIMEZONE=GMT+08` : Default system timezone (Singapore)
+ `LANGUAGE=en_US.UTF-8` : Used to configure OS language support
+ `APTGET_PRESCRIPT=""` : Commands to execute prior to aptget install/upgrade on bootup
+ `APTGET_INSTALL=""` : Performs the installation of the following if missing on bootup
+ `APTGET_UPGRADE=""` : Performs an apt-get upgrade on bootup
+ `APTGET_POSTSCRIPT=""` : Commands to execute after aptget install/upgrade on bootup

See `base/README.md` for more details.

## Standard volume mount point

+ `/workspace` : Contains all the various persistant files related to the image

See `base/README.md` for more details.
