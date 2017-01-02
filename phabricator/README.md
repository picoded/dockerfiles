# Environment variables notes
As seen =)

```
#########################################
#
# Declare environment variables
#
#########################################

# Performs a phabricator upgrade on boot
# (note this can backfire, so do make due consideration on its usage)
ENV UPGRADE_ON_BOOT false

# Site base url to use
ENV BASE_URL ""

#
# MYSQL storage, host, port, user, passwords
#
ENV MYSQL_FILE_STORAGE 9000000
ENV MYSQL_HOST mysql_host_here
ENV MYSQL_PORT 3306
ENV MYSQL_USER phabricator
ENV MYSQL_PASS password_over_here

# PHP script to inject
ENV PREAMBLE_SCRIPT ""

# Additional script options
ENV PRE_SCRIPT ""

# Enables / Disable background phd thread
ENV BACKGROUND_THREAD true

#
# SMTP settings, provide atleast an SMTP host to configure
#
ENV SMTP_HOST ""
ENV SMTP_PORT 25
ENV SMTP_USER "phabricator"
ENV SMTP_PASS ""
ENV SMTP_PROT ""
ENV MAIL_ADAPTER "PhabricatorMailImplementationPHPMailerAdapter"

#
# More JSON local config (to add-on)
#
ENV JSON_PARAMS ""
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
