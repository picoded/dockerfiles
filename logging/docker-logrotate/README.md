# picoded/docker-logrotate

https://hub.docker.com/r/picoded/docker-logrotate/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-logrotate/

## Summary

> Normalising docker log handling, to IMO a saner default

You will need the following volume mounted, with read/write access.
`/var/lib/docker/containers/:/var/lib/docker/containers/:rw`

## More details

An oversimplified logrotation setup for docker.
That functions as a base default for docker deployments.

This was designed to be used along with FileBeat.

https://hub.docker.com/r/picoded/docker-filebeat/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-filebeat/

For crtical production use of logs however, you will need to setup,
a full log infrastructure stack. Such as ELK

And even without filebeat, I would still ensure that this is running,
so that individual container logs do not build up to gigbyte sizes.

The following is the summary of the container.

+ Works with FileBeat
+ Clearing of log entry within 10 days
+ Accept possible log loss (due to copytruncate) on rotation

## Docker and copytruncate issue

Copytruncate issue : https://linux.die.net/man/8/logrotate
(Search the copytruncate segment)

Docker issue : https://github.com/docker/docker/issues/7333

Because it seem that docker will not be supporting the logging 
filehandle change notification "anytime soon", without re-configuring 
the container. Usage of copytruncate is still needed for containers,
not having their own dedicate logging infrastructure.

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
