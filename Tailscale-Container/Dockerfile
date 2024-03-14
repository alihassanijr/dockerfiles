FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ='America/Los_Angeles'
RUN apt-get -y update
RUN apt-get -y install \
      curl \
      coreutils \
      ssh

RUN sh -c 'curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null'
RUN sh -c 'curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list'

RUN apt-get update -y
RUN apt-get install tailscale -y

RUN mkdir /app

COPY ./entrypoint.sh /app

COPY authorized_keys /root/.ssh/
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

WORKDIR /app

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

ENTRYPOINT ./entrypoint.sh
