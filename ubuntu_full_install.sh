#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "This script must be run with an active Internet connection"
   exit 1
fi

DOCKUSER=$(cat /etc/passwd | grep 1000 | cut -d":" -f1)

apt-get update && \
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get install docker-ce docker-ce-cli containerd.io

usermod -aG docker $DOCKUSER

mkdir -p /tmp/ssj && \
cd /tmp/ssj && \
docker pull scarfaced/ssj:latest

docker image rm $(docker images -q --filter "dangling=true") &>/dev/null

wget https://raw.githubusercontent.com/thirdbyte/ssj/main/.bashrc && \
mkdir -p /home/ssj && \
cp .bashrc /home/ssj/.bashrc && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.desktop && \
wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png && \
mkdir -p /usr/local/share/applications && \
cp ssj.desktop /usr/local/share/applications/ssj.desktop && \
cp ssj.png /usr/local/share/applications/ssj.png && \
mkdir -p /usr/local/bin && \
echo "xhost +local:root && docker run --rm --shm-size=4g --workdir=/root --hostname=ssj --net=host --privileged -e DISPLAY -v /home/ssj:/root scarfaced/ssj:latest terminator && xhost -local:root" > /usr/local/bin/ssj && \
chmod +x /usr/local/bin/ssj && \
cd /tmp && \
rm -rf /tmp/ssj
