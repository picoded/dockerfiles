# picoded/docker-logrotate

https://hub.docker.com/r/picoded/docker-logrotate/
https://github.com/picoded/dockerfiles/tree/master/logging/docker-logrotate/

## Summary

> Normalising docker log handling, to IMO a saner default

You will need the following volume mounted, with read/write access.
`/var/lib/docker/containers/`

## More details

An oversimplified logrotation setup for docker.
That functions as a base default for docker deployments.

For practical production use of logs, you will need to setup,
a log infrastructure stack. 

However I will still keep this logrotation utility running
to ensure the less "important" logs do not build up to gigbyte sizes.

The following is the summary of the container.

+ Clearing of log entry within 24 hours. To prevent gigbyte size log folders.
+ Works with FileBeat - With 5~10 minutes delay
+ Accept possible log loss (due to copytruncate)

## Docker and copytruncate issue

Docker issue : https://github.com/docker/docker/issues/7333

Because it seem that docker will not be supporting the logging 
filehandle change notification "anytime soon", without re-configuring 
the container. Usage of copytruncate is still needed for containers,
not having their own dedicate logging infrastructure.

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
