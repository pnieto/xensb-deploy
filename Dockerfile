# pnietoiglesias/xensb-deploy/Dockerfile
#
# VERSION    0.1
#

FROM ubuntu:14.04

RUN apt-get update && apt-get -y install git emacs24-nox

RUN mkdir /root/.ssh
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

WORKDIR /xensb
ENTRYPOINT ["/app/entrypoint.sh"]