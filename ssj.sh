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
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.desktop && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png && \
mkdir /usr/local/share/applications && \
cp ssj.desktop /usr/local/share/applications/ssj.desktop && \
cp ssj.png /usr/local/share/applications/ssj.png && \
cd /tmp && \
rm -rf /tmp/ssj
