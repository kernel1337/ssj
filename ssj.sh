#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "This script must be run with Docker installed"
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "This script must be run as root with an active Internet connection"
   exit 1
fi

mkdir /tmp/ssj && \
cd /tmp/ssj && \
wget https://raw.githubusercontent.com/thirdbyte/demon-docker/master/Dockerfile && \
docker build -t ssj . && \
wget https://raw.githubusercontent.com/thirdbyte/demon-docker/master/root/.bashrc && \
mkdir /home/ssj && \
cp .bashrc /home/ssj/.bashrc && \
wget https://gist.githubusercontent.com/thirdbyte/3b4596ae93c09b3fd950d35329f203c2/raw/ef9cc873b6d0e5c440664851387d612ae1837e80/ssj.desktop && \
wget https://user-images.githubusercontent.com/59290972/96023362-f173f800-0e6f-11eb-8567-769e194beaec.png && \
cp *.desktop /usr/local/share/applications/ssj.desktop && \
cp *png /usr/local/share/applications/ssj.png && \
cd /tmp && \
rm -rf /tmp/ssj
