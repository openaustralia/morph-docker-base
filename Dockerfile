FROM ubuntu:12.04
MAINTAINER Matthew Landauer <matthew@oaf.org.au>

RUN apt-get update
RUN apt-get -y install git time

RUN mkdir /repo

# Give the scraper user the same uid as deploy on the docker server
# TODO Currently hardcoded values
RUN addgroup --gid 4243 scraper
RUN adduser --home /data --disabled-login --gecos "Scraper User" --uid 4243 --gid 4243 scraper

VOLUME /repo
VOLUME /data
WORKDIR /data

# Add certificate authority used by mitmproxy
# NB This certificate expires in 2016
# Also needs to be identical to the cert at mitmproxy/mitmproxy-ca.pem in
# https://github.com/openaustralia/morph

ADD mitmproxy-ca.pem /etc/ssl/certs/mitmproxy-ca.pem
