# base
The various folders of Dockerfile's here represent base images, and/or image templates used extensively
within `picoded` and `uilicious` deployment environment.

These normally will not have any useful command on their own

Generally they will have the following.

# Standard environment variables

## TIMEZONE
`ENV TIMEZONE=GMT+08`

This represents the timezone of `Singapore`, where we `picoded` originates from. Until some apocalyptic earth plate
shifting occurs, Feel free to change this to your respective timezone using the format found for `TZ` in the following.

+ https://www.gsp.com/support/virtual/admin/unix/tz/gmt/
+ https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

Note that this configuration is ignored if blank. A legitimate use case would be when mounting `/etc/localtime:/etc/localtime:ro`

Runs the following in primer (if not blank) : 
`export TZ="$TIMEZONE"`

## LANGUAGE
`ENV LANGUAGE=en_US.UTF-8`

Sets language to UTF8 : this works in almost all cases, except very region and language specific edge cases.
Not convinced?, let [Joel (on software) Spolsky convince you then](https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses)

Runs the following in primer (if not blank) : 
`locale-gen "$LANGUAGE"`

## APTGET_PRESCRIPT
`ENV APTGET_PRESCRIPT=""`

Bash script to 'eval' and execute, prior to the APTGET_INSTALL, and APTGET_UPGRADE steps.
This is mainly useful for setting up custom apt-get distribution, to pull packages from.

Note that for `ubuntu-base` and their derivatives. Node.js distribution is already included.
This is setup in accordance to: https://nodejs.org/en/download/package-manager/

Runs the following in primer (if not blank) : 
`eval("$APTGET_PRESCRIPT")`

## APTGET_INSTALL
`ENV APTGET_INSTALL=""`

For every package listed inside, separated by a space. It does a `which name`.
And if not found, does the respective install step for it `apt-get install -y name`

Runs the following in primer (if not blank), note simplified, not actual steps : 
`apt-get update; if [ -n "$(which $name)"]; then apt-get install -y $name; fi`

## APTGET_UPGRADE
`ENV APTGET_UPGRADE=false`

Does an apt-get upgrade, ensures all your packages are up-to-date. On booting up the docker image.

Runs the following in primer (if true) : 
`apt-get update; apt-get upgrade -y;`

## APTGET_POSTSCRIPT
`ENV APTGET_POSTSCRIPT=""`

Bash script to 'eval' and execute, after APTGET_INSTALL, and APTGET_UPGRADE steps.

Runs the following in primer (if not blank) : 
`eval("$APTGET_PRESCRIPT")`

# Standard /workspace folder
This generally represents the data storage directory. In several cases one can simply mount the `/workspace` folder. 
And be done with, for all you data backup requirements. This greatly simplify the backup process.

However for certain repositories it might be more "complicated". Check the README of those image for more details.

This is also normally the docker `WORKDIR`, or the starting folder if you were to SSH into it.

Actual usage will be image specific

# Standard /entrypoint folder
Contains the various entrypoint scripts, and/or layers of entrypoint's scripts, defined by the picoded docker
image chain. This is normally simply `/entrypoint/primer.sh` but maybe image specific. Knowledge of this folder
is only needed for those looking into maintaining these Dockerfile's / extending them.

# Standard /appspace folder
By default this is a symbolic link to `/workspace`.
However its meant for the application specific folder space.

Which maybe changed / updated / upgraded over various versions. If the application have a `/var/app-installation` 
`/appspace` will be a symbolic link to `/var/app-installation`.

Actual usage will be image specific.
