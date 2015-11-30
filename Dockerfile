FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl \
                                         python-pip \
                                         ssh \
                                         wget

ENV DOCKER_CERT_PATH /root/.sdc/docker/dissipate
ENV DOCKER_HOST tcp://us-sw-1.docker.joyent.com:2376
ENV DOCKER_CLIENT_TIMEOUT 300
ENV COMPOSE_HTTP_TIMEOUT 300
ENV DOCKER_TLS_VERIFY 1

RUN mkdir /root/.ssh
ADD ./id_rsa /root/.ssh
ADD ./id_rsa.pub /root/.ssh
RUN chmod 700 -R /root/.ssh

RUN wget -qO- https://get.docker.com/ | sh

RUN cd /tmp && curl -O https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh && /bin/bash sdc-docker-setup.sh https://us-sw-1.api.joyentcloud.com dissipate /root/.ssh/id_rsa

RUN pip install docker-compose
