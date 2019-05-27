FROM phusion/baseimage:0.11
MAINTAINER Dmitriy S <smalllark@gmail.com>
ENV PYPICLOUD_VERSION 1.0.11

# Install packages required
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq && \
    apt-get install -y python3-pip python3-dev libpq-dev && \
    pip3 install virtualenv && \
    virtualenv /env && \
    /env/bin/pip3 install pypicloud==$PYPICLOUD_VERSION uwsgi pastescript flywheel psycopg2 && \
    mkdir -p /var/lib/pypicloud && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./etc /etc

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
