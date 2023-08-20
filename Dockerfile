FROM docker.io/ubuntu/postgres as pgbase

RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y imagemagick poppler-utils clamav pdftk
RUN apt-get install -y sudo wget curl git systemctl vim postgis

FROM pgbase

RUN apt-get install -y redis
RUN echo "supervised systemd" >> /etc/redis/redis.conf
COPY redis-setup.sh /tmp/
RUN cat /tmp/redis-setup.sh docker-entrypoint.sh > docker-entrypoint-2.sh
RUN mv docker-entrypoint-2.sh docker-entrypoint.sh
