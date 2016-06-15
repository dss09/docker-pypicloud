FROM phusion/baseimage:0.9.18
MAINTAINER Dmitriy S <smalllark@gmail.com>

# Install packages required
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
    apt-get install -y python-pip python2.7-dev libpq-dev && \
    pip install virtualenv && \
    virtualenv /env && \
    /env/bin/pip install pypicloud==0.3.13 uwsgi pastescript flywheel psycopg2 && \
    mkdir -p /var/lib/pypicloud && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./etc /etc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
