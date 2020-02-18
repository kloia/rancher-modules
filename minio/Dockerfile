FROM minio/minio
ENV MINIO_ACCESS_KEY backup-test
ENV MINIO_SECRET_KEY backup-secret-test
EXPOSE 443
ENTRYPOINT mkdir -p /storage/backupbucket && exec /usr/bin/minio server /storage