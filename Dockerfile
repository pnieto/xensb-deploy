# pnietoiglesias/xensb-deploy/Dockerfile
#
# VERSION    0.1
#

FROM ansible/ubuntu14.04-ansible:stable

ADD https://get.docker.com/builds/Linux/x86_64/docker-1.5.0 /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker
RUN apt-get update && apt-get -y install python-pip
#RUN pip install docker-py
ADD . /xensb-deploy
WORKDIR /xensb-deploy
