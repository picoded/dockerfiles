# picoded/squid-proxy
It is a squid forward proxy server that uses basic authentication.

## Summary and configuration

<!-- To indicate the username and password for the basic authentication, pass in the values to the enviroment variables.
```
# username of the basic authentication
USERNAME=<your value>

# password of the basic authentication
PASSWORD=<your value>

# By default it will be 
USERNAME=proxy_user
PASSWORD=proxy_password
``` -->

The `squid.conf` is generated during the execution of `entrypoint.sh` and the template of the `squid.conf` can be found at `squid-template.conf`. 