#!/bin/bash

if ! docker --version 2>/dev/null | grep -q 'build'; then
   echo "Docker is not installed. Terminating..."
   exit 1
fi

if ! groups | grep -q "docker"; then
   echo "The user '$USER' is not present in the 'docker' group. Terminating..."
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "Could not connect to the Internet. Terminating..."
   exit 1
fi

mkdir -p /tmp/ssj && \
cd /tmp/ssj && \
docker pull scarfaced/ssj:latest && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/.bashrc && \
mkdir -p $HOME/.ssj && \
cp .bashrc $HOME/.ssj/.bashrc && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.desktop && \
mkdir -p $HOME/.local/share/applications && \
cp ssj.desktop $HOME/.local/share/applications/ssj.desktop && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png && \
mkdir -p $HOME/.icons && \
cp ssj.png $HOME/.icons/ssj.png && \
mkdir -p $HOME/.local/bin && \
echo "xhost +local:root && docker run --init --rm --shm-size=4g --workdir=/root --hostname=ssj --net=host --privileged -e DISPLAY -v $HOME/.ssj:/root scarfaced/ssj:latest terminator && if ! ps aux | grep '[d]ocker' | grep -q 'ssj'; then xhost -local:root; fi" > $HOME/.local/bin/ssj && \
chmod +x $HOME/.local/bin/ssj && \
echo "export PATH=$HOME/.local/bin:$PATH" >> $HOME/.bashrc && \
cd /tmp && \
rm -rf /tmp/ssj && \
echo "" && \
echo "================================================================================================" && \
echo "Your everyday Linux distribution has successfully gone Super Saiyan! Reboot to see it in action." && \
echo "================================================================================================"
docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
