FROM alpine:3.21.3

LABEL maintainer="Joshua Snyder"
LABEL description="A simple container to backup a Minecraft world to a S3 bucket."
LABEL version="1.0"

RUN apk add --no-cache bash s3cmd

COPY backup.sh /backup.sh
CMD [ "/backup.sh" ]