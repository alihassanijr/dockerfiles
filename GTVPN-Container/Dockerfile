FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ='America/Los_Angeles'
RUN apt-get update -y
RUN apt-get install ssh -y
RUN apt-get install gpg curl -y 

RUN echo \
  'deb http://download.opensuse.org/repositories/home:/bluca:/openconnect:/release/Ubuntu_20.04/ /' \
  | tee /etc/apt/sources.list.d/home:bluca:openconnect:release.list

RUN curl -fsSL \
  https://download.opensuse.org/repositories/home:bluca:openconnect:release/Ubuntu_20.04/Release.key \
  | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_bluca_openconnect_release.gpg > /dev/null

RUN apt update -y
RUN apt install openconnect -y

RUN mkdir /app

COPY ./entrypoint.sh /app
COPY username /app

COPY authorized_keys /root/.ssh/
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

WORKDIR /app

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

ENTRYPOINT ./entrypoint.sh
