FROM gliderlabs/alpine
MAINTAINER linh@jmango360.com

ARG MONGO_USER="root"
ARG MONGO_PASS
ARG MONGO_HOST="localhost"
ARG MONGO_BACKUP_DIRECTORY="/backup"
ARG MONGO_BACKUP_DB
ARG MONGO_STORED_DAY="7"


ENV MONGO_USER=${MONGO_USER}
ENV MONGO_PASS=${MONGO_PASS}
ENV MONGO_HOST=${MONGO_HOST}
ENV MONGO_BACKUP_DIRECTORY=${MONGO_BACKUP_DIRECTORY}
ENV MONGO_BACKUP_DB=${MONGO_BACKUP_DB}
ENV MONGO_STORED_DAY=${MONGO_STORED_DAY}

RUN apk add --no-cache mongodb-tools bash \
    && apk add --update coreutils \
    && rm -rf /var/cache/apk/*

ADD ./script/Backup_MongoDB_Database.sh /
RUN chmod +x /Backup_MongoDB_Database.sh

ENTRYPOINT ["/Backup_MongoDB_Database.sh"]

