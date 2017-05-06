# Summary

This repository contains a collection of "Dockerfile" for their respective automated build in Docker hub,
found at https://hub.docker.com/u/picoded/

# hub.docker.com

Note that if your seeing this README directly in docker, chances are you are using one of the images that will 
either be in the process of being rewritten. Or replaced;

# Issue filling

Any problems / comments / kudos should be filed at github =)
https://github.com/picoded/dockerfiles

# Overhaul in progress

Note that gradually overtime, I would be refactoring these various file to a more structured format

# Organized Dockerfile

See their respective README for more details. These Dockerfile, typically represents various iterations,
of all my DevOps docker experiences. Refined for multiple use cases.

+ (base)[https://github.com/picoded/dockerfiles/tree/master/base]
	+ (ubuntu-base)[https://github.com/picoded/dockerfiles/tree/master/base/ubuntu-base]
	+ (ubuntu-openjdk-8-jdk)[https://github.com/picoded/dockerfiles/tree/master/base/ubuntu-openjdk-8-jdk]
+ git-cloner
	+ (git-cloner-base)[https://github.com/picoded/dockerfiles/tree/master/git-cloner/git-cloner-base]
	+ (git-cloner-plus)[https://github.com/picoded/dockerfiles/tree/master/git-cloner/git-cloner-plus]
	+ git-cloner-* (see: git-cloner-plus)[https://github.com/picoded/dockerfiles/tree/master/git-cloner/git-cloner-plus]
+ zip-cloner
	+ (zip-cloner-base)[https://github.com/picoded/dockerfiles/tree/master/zip-cloner/zip-cloner-base]
	+ (zip-cloner-plus)[https://github.com/picoded/dockerfiles/tree/master/zip-cloner/zip-cloner-plus]
	+ zip-cloner-* (see: zip-cloner-plus)[https://github.com/picoded/dockerfiles/tree/master/zip-cloner/zip-cloner-plus]
	
# Unorganized Dockerfile

Every other folder not in organized Dockerfile, these ranges from awesome, to crap, to not working.

Even I was a Docker noob once, and had to start from somewhere =P

# License 

`MIT License`

This is an obvious choice due to the highly public nature of these Docker repo's and how easy, 
or commonly the scripts can be replicated.

For most of the Dockerfiles, I wager that someone out there has something similar.

Hopefully mine is better, Cheers!

Best Regards,
Eugene @ Picoded.com

# Some general guidelines

+ Follow the standard environment as specified inside (base/README)[https://github.com/picoded/dockerfiles/tree/master/base]
+ Do not include external files (where practical), echo and write it out in Dockerfile instead.
	+ This is because with layers and layers of file add, is un-viewable and un-traceable in Docker hub.
+ Have a sane default for everything (if possible).
	+ I want things to be deployable without configuration
	+ Exception is for databases, or similar integration
+ For application servers, build using (ubuntu-base)[https://github.com/picoded/dockerfiles/tree/master/base/ubuntu-base]
	+ For everthing else priotise according to the following : Offical repo, alpine, debian, ubuntu-base
