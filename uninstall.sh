#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

docker image rm scarfaced/ssj:latest &>/dev/null
docker image rm ssj:latest &>/dev/null
docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
rm -rf $HOME/.ssj &>/dev/null
rm -rf $HOME/.local/bin/ssj &>/dev/null
rm -rf $HOME/.local/share/applications/ssj.* &>/dev/null
rm -rf /tmp/ssj &>/dev/null
