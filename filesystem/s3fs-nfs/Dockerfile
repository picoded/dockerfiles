#
# S3FS-NFS : Built ontop S3FS
#
# VERSION               1.0.0
FROM picoded/s3fs

#
# Installing NFS
#
RUN apt-get update && \
	apt-get install -y nfs-kernel-server;

#
# NFSv4 ports
#
EXPOSE 111 2049

#
# Mount the S3 Bucket as an NFS export
#
RUN echo '#!/bin/bash' > /entrypoint/s3fs-nfs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs-nfs.sh && \
	echo '# Setup NFS config'                                                     >> /entrypoint/s3fs-nfs.sh && \
	echo 'echo "${S3FS_MOUNTPOINT}   *(rw,sync,fsid=0,crossmnt,no_subtree_check,no_root_squash)" > /etc/exports' >> /entrypoint/s3fs-nfs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs-nfs.sh && \
	echo '# Start NFS server'                                                     >> /entrypoint/s3fs-nfs.sh && \
	echo 'systemctl start nfs-kernel-server'                                      >> /entrypoint/s3fs-nfs.sh && \
	echo ''                                                                       >> /entrypoint/s3fs-nfs.sh && \
	echo '# Chain the execution commands'                                         >> /entrypoint/s3fs-nfs.sh && \
	echo 'exec "$@"'                                                              >> /entrypoint/s3fs-nfs.sh && \
	chmod +x /entrypoint/s3fs-nfs.sh;

# Chain up the entrypoints
ENTRYPOINT [ "/entrypoint/primer.sh", "/entrypoint/s3fs.sh", "/entrypoint/s3fs-nfs.sh" ]