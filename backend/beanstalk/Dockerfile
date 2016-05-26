FROM debian:jessie

MAINTAINER  Coomy Chang <coomysky@gmail.com>


RUN     apt-get update && \
        apt-get install --no-install-recommends --no-install-suggests -y beanstalkd && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE  11300

CMD     ["beanstalkd","-p","11300"]
