#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "UID 0 is required. Terminating..." 
   exit 1
fi

if ! ping 1.1.1.1 2>/dev/null | grep -q "ttl="; then
   echo "Could not connect to the Internet. Terminating..."
   exit 1
fi

DOCKUSER=$(cat /etc/passwd | grep 1000 | cut -d":" -f1)

apt-get update && \
apt-get dist-upgrade -y && \
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    wget && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get install -y docker-ce docker-ce-cli containerd.io && \
apt-get autoremove -y && \
apt-get clean -y

usermod -aG docker $DOCKUSER

mkdir -p /tmp/ssj && \
cd /tmp/ssj && \
docker pull scarfaced/ssj:latest

docker image rm $(docker images -q --filter "dangling=true") &>/dev/null

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
echo "xhost +local:root && docker run --rm --shm-size=4g --workdir=/root --hostname=ssj --net=host --privileged -e DISPLAY -v $HOME/.ssj:/root scarfaced/ssj:latest terminator && xhost -local:root" > $HOME/.local/bin/ssj && \
chmod +x $HOME/.local/bin/ssj && \
echo "export PATH=$HOME/.local/bin:$PATH" >> $HOME/.bashrc && \
cd /tmp && \
rm -rf /tmp/ssj

echo ""
echo "==========================================================================="
echo "Your Ubuntu has successfully gone Super Saiyan! Reboot to see it in action."
echo "==========================================================================="
