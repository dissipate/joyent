FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl \
                                         nodejs \
                                         npm \
                                         python-pip \
                                         ssh \
                                         wget

ENV DOCKER_CERT_PATH /root/.sdc/docker/dissipate
ENV DOCKER_HOST tcp://us-sw-1.docker.joyent.com:2376
ENV DOCKER_CLIENT_TIMEOUT 300
ENV COMPOSE_HTTP_TIMEOUT 300
ENV DOCKER_TLS_VERIFY 1

ENV SDC_URL https://us-sw-1.api.joyentcloud.com
ENV SDC_ACCOUNT dissipate
#ENV SDC_KEY_ID ssh-keygen -l -f /home/root/.ssh/id_rsa.pub | awk '{print $2}' | tr -d '\n'

RUN mkdir /root/.ssh
ADD ./id_rsa /root/.ssh
ADD ./id_rsa.pub /root/.ssh
RUN chmod 700 -R /root/.ssh

RUN wget -qO- https://get.docker.com/ | sh

RUN cd /tmp && curl -O https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh && /bin/bash sdc-docker-setup.sh https://us-sw-1.api.joyentcloud.com dissipate /root/.ssh/id_rsa

RUN npm install -g smartdc
RUN npm install -g json
RUN ln -s /usr/bin/nodejs /usr/bin/node 

RUN pip install docker-compose
