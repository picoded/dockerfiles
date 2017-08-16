# picoded/file-runner

https://hub.docker.com/r/picoded/file-runner/
https://github.com/picoded/dockerfiles/tree/master/network/file-runner

## Summary and configuration
A simple container, used to write a single file.

Normally this is used to write a config file, that is mounted into another container. As part of a larger docker template.

Common examples, include application config setup.

``` 
#
# File directory, name, and content configurations
#
ENV FILE_DIR "/workspace/"
ENV FILE_NAME "config.json"
ENV FILE_DATA "{ }"
```

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles
