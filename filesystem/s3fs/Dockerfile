#
# S3FS : Built ontop of ubuntu
#
# VERSION               1.0.0
FROM picoded/ubuntu-base

#
# Installing dependencies
# https://github.com/s3fs-fuse/s3fs-fuse
#
RUN apt-get update && \
	apt-get install -y automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config;

#
# Performing build steps
#
ENV S3FS_GITHASH "ae4caa96a002151615f241d87af59b15e933ec47"
RUN cd /tmp && \
	git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
	cd s3fs-fuse \
	git reset --hard "$S3FS_GITHASH" && \
	./autogen.sh && \
	./configure && \
	make && \
	make install && \
	rm -R /tmp/*;

#
# Log the version in Docker build
#
RUN s3fs --version && \
	s3fs --help;

#
# AWS / S3FS variables
#
# By default S3FS uses cache in /tmp, when the drive has atleast 2GB free space
#
ENV \
	S3FS_MOUNTPOINT='/workspace' \
	S3FS_BUCKET_NAME='' \
	S3FS_ACCESS_KEY_ID='' \
	S3FS_ACCESS_KEY_SECRET='' \
	S3FS_URL='https://s3.amazonaws.com' \
	S3FS_RUNMODE='-f' \
	S3FS_AUTHFILE='/root/.s3fs' \
	S3FS_CACHE_DIR='/tmp/s3fs' \
	S3FS_CACHE_ENSURE_DISKFREE_MB='2048' \
	S3FS_OPTIONS='-o use_xattr'

#
# This script was modified heavily from
# https://github.com/panubo/docker-s3fs/blob/master/entry.sh
#
RUN echo '#!/bin/bash' > /entrypoint/s3fs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs.sh && \
	echo '# Configuration checks'                                                 >> /entrypoint/s3fs.sh && \
	echo 'if [ -z "${S3FS_BUCKET_NAME}" ]; then'                                  >> /entrypoint/s3fs.sh && \
	echo '    echo "Error: S3FS_BUCKET_NAME is not specified"'                    >> /entrypoint/s3fs.sh && \
	echo '    exit 128'                                                           >> /entrypoint/s3fs.sh && \
	echo 'fi'                                                                     >> /entrypoint/s3fs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs.sh && \
	echo '# Write auth file if it does not exist'                                 >> /entrypoint/s3fs.sh && \
	echo 'if [ ! -f "${S3FS_AUTHFILE}" ]; then'                                   >> /entrypoint/s3fs.sh && \
	echo '    if [ -z "${S3FS_ACCESS_KEY_ID}" ] || [ -z "{$S3FS_ACCESS_KEY_SECRET}" ]; then'          >> /entrypoint/s3fs.sh && \
	echo '        echo "Error: Missing S3FS_ACCESS_KEY_ID/SECRET or ${S3FS_AUTHFILE} not provided"'   >> /entrypoint/s3fs.sh && \
	echo '        exit 128'                                                                           >> /entrypoint/s3fs.sh && \
	echo '    fi'                                                                                     >> /entrypoint/s3fs.sh && \
	echo '    echo "${S3FS_ACCESS_KEY_ID}:${S3FS_ACCESS_KEY_SECRET}" > ${S3FS_AUTHFILE}'              >> /entrypoint/s3fs.sh && \
	echo '    chmod 400 ${S3FS_AUTHFILE}'                                                             >> /entrypoint/s3fs.sh && \
	echo 'fi'                                                                     >> /entrypoint/s3fs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs.sh && \
	echo '# Prepare S3FS Cache options'                                           >> /entrypoint/s3fs.sh && \
	echo 'S3FS_CACHE_OPT=""'                                                      >> /entrypoint/s3fs.sh && \
	echo 'if [ -z "${S3FS_CACHE_DIR}" ]; then'                                    >> /entrypoint/s3fs.sh && \
	echo '    mkdir -p "${S3FS_CACHE_DIR}"'                                       >> /entrypoint/s3fs.sh && \
	echo '    S3FS_CACHE_OPT="-o use_cache=\\"${S3FS_CACHE_DIR}\\" -o ensure_diskfree=${S3FS_CACHE_ENSURE_DISKFREE_MB}"' >> /entrypoint/s3fs.sh && \
	echo 'fi'                                                                     >> /entrypoint/s3fs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs.sh && \
	echo 'echo "==> [picoded/ufs-client-stack] : Mounting S3 Filesystem"'         >> /entrypoint/s3fs.sh && \
	echo 'mkdir -p ${S3FS_MOUNTPOINT}'                                            >> /entrypoint/s3fs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs.sh && \
	echo '# s3fs mount command'                                                   >> /entrypoint/s3fs.sh && \
	echo 's3fs $S3FS_RUNMODE $S3FS_CACHE_OPT $S3FS_OPTIONS -o passwd_file="${S3FS_AUTHFILE}" -o url=${S3FS_URL} ${S3FS_BUCKET_NAME} ${S3FS_MOUNTPOINT}' >> /entrypoint/s3fs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs.sh && \
	echo 'echo "==> [picoded/ufs-client-stack] : Entrypoint Chain"'               >> /entrypoint/s3fs.sh && \
	echo 'exec "$@"'                                                              >> /entrypoint/s3fs.sh && \
	chmod +x /entrypoint/s3fs.sh;

# Chain up the entrypoints
ENTRYPOINT [ "/entrypoint/primer.sh",  "/entrypoint/s3fs.sh" ]