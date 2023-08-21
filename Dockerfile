FROM docker.io/ubuntu/postgres as pgbase

RUN apt-get update; apt-get upgrade -y
RUN apt-get install -y imagemagick poppler-utils clamav pdftk
RUN apt-get install -y sudo wget curl git systemctl vim postgis

FROM pgbase

# Redis
RUN apt-get install -y redis
RUN echo "supervised systemd" >> /etc/redis/redis.conf
COPY redis-setup.sh /tmp/
RUN cat /tmp/redis-setup.sh docker-entrypoint.sh > docker-entrypoint-2.sh
RUN mv docker-entrypoint-2.sh docker-entrypoint.sh

# Ruby
RUN apt-get install -y libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# Dev user
RUN adduser devel
WORKDIR /home/devel
USER devel
RUN echo 'export PATH=$PATH:~/.rbenv/bin' >> ~/.bashrc
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
# RUN /home/devel/.rbenv/bin/rbenv init
# RUN /home/devel/.rbenv/bin/rbenv install 3.2.2
RUN /home/devel/.rbenv/bin/rbenv install 3.1.4

USER root
WORKDIR /