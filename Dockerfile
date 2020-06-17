FROM ubuntu:focal-20200423
LABEL maintainer="https://japancellar.jp/"

ENV DEBIAN_FRONTEND=noninteractive
# apt
RUN apt-get update -qq && \
  apt-get install -qq -y --no-install-recommends --no-install-suggests \
    curl                 \
    git                  \
    less                 \
    net-tools            \
    vim                  \
    wget                 \
    software-properties-common \
    docker.io            \
    lvm2                 \
    kmod                 \
    duply                \
    mariadb-client-core-10.3 \
    redis-tools          \
    python3-pip          \
    python3-boto3        \
    python3-ijson        \
    && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
  apt-get update -qq && \
  apt-get install -qq -y --no-install-recommends --no-install-suggests \
    google-cloud-sdk     \
    && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# supervisord, mysql-connector-python, timeout-decorator, google-cloud-pubsub, slackclient, docker
RUN pip3 install supervisor==4.2.0 mysql-connector-python timeout-decorator google-cloud-pubsub slackclient docker && \
  mkdir -p /etc/supervisord/conf.d && \
  mkdir -p /var/log/supervisord && \
  mkdir -p /var/run/supervisord && \
  echo_supervisord_conf > /etc/supervisord/supervisord.conf.default

# go-cron
COPY go-cron /usr/local/bin/go-cron

# go-redis-setlock
COPY go-redis-setlock /usr/local/bin/go-redis-setlock

# user
RUN groupadd -g 1000 app && \
  useradd -m -d /var/www/app -s /bin/bash -u 1000 -g 1000 app && \
  groupadd -g 120 dockerapp && \
  gpasswd -a app dockerapp

