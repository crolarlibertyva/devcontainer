FROM ubuntu/postgres as pgbase

RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y imagemagick poppler-utils clamav pdftk
RUN apt-get install -y sudo wget curl git systemctl vim postgis

FROM pgbase

RUN apt-get install -y redis
COPY redis-setup.sh /docker-entrypoint-initdb.d/
