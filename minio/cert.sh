#!/bin/bash
openssl genrsa -out private.key 2048
openssl req -new -x509 -days 3650 -key private.key -out public.crt -subj "/C=US/ST=state/L=location/O=organization/CN=MINIO_HOST_NAME"

docker run -d -p 9000:9000 -e "MINIO_ACCESS_KEY=" -e "MINIO_SECRET_KEY=" -v /opt/config:/root/.minio/certs/ minio server /data