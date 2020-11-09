#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "This script requires Docker to be installed"
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "This script must be run with an active Internet connection"
   exit 1
fi

mkdir -p /tmp/ssj && \
cd /tmp/ssj && \
docker pull scarfaced/ssj:latest

docker image rm $(docker images -q --filter "dangling=true") &>/dev/null

wget https://raw.githubusercontent.com/thirdbyte/ssj/main/.bashrc && \
mkdir -p $HOME/.ssj && \
cp .bashrc $HOME/.ssj/.bashrc && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.desktop && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png && \
mkdir -p $HOME/.local/share/applications && \
cp ssj.desktop $HOME/.local/share/applications/ssj.desktop && \
cp ssj.png $HOME/.local/share/applications/ssj.png && \
mkdir -p $HOME/.local/bin && \
echo "xhost +local:root && docker run --rm --shm-size=4g --workdir=/root --hostname=ssj --net=host --privileged -e DISPLAY -v $HOME/.ssj:/root scarfaced/ssj:latest terminator && xhost -local:root" > $HOME/.local/bin/ssj && \
chmod +x $HOME/.local/bin/ssj && \
echo "export PATH=$HOME/.local/bin:$PATH" >> $HOME/.bashrc && \
cd /tmp && \
rm -rf /tmp/ssj
