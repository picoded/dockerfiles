#!/bin/sh

# Indicate that this script will fail on any error
set -e

# Configuration directory for squid, exporting for envsubst
SQUID_CONF_DIR="/etc/squid3"
export SQUID_CONF_DIR="$SQUID_CONF_DIR"

# Squid config template
SQUID_TEMPLATE=$(cat /entrypoint/squid-template.conf)

# Squid config to use, after environment variable substitution
SQUID_CONFIG=$(echo "$SQUID_TEMPLATE" | envsubst)

# Overwrite the username and password file
# htpasswd -bc does not append the file
echo "## Configuring HTTPAUTH user / password"
htpasswd -bc "$SQUID_CONF_DIR/passwd" "$USERNAME" "$PASSWORD"

# Write the squid config file
echo "## Writting the squid.conf file"
echo "$SQUID_CONFIG" > "$SQUID_CONF_DIR/squid.conf"

# Execute squid with additional args
echo "## Executing squid"
if [ "$SQUID_DEBUG" = true ]; then
    squid3 -f "$SQUID_CONF_DIR/squid.conf" -NXYCd 9 $@
else
    squid3 -f "$SQUID_CONF_DIR/squid.conf" -NYCd 9 $@
fi