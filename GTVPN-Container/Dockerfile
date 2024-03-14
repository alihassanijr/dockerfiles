FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ='America/Los_Angeles'
RUN apt-get -y update
RUN apt-get -y install \
      openconnect \
      ssh

RUN mkdir /app

COPY ./entrypoint.sh /app
COPY username /app

COPY authorized_keys /root/.ssh/
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

WORKDIR /app

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

ENTRYPOINT ./entrypoint.sh
