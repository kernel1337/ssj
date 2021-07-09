#!/bin/bash

function check {

    if ! docker --version >/dev/null; then
        echo "Docker is not installed. Terminating..."
        exit 1
    fi

    if ! groups | grep -q "docker"; then
        echo "The user '$USER' is not present in the 'docker' group. Terminating..."
        exit 1
    fi

}

check

docker image rm scarfaced/ssj:latest &>/dev/null
docker image rm ssj:latest &>/dev/null
docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
rm -rf $HOME/.ssj &>/dev/null
rm -rf $HOME/.local/bin/ssj &>/dev/null
rm -rf $HOME/.local/share/applications/ssj.desktop &>/dev/null
rm -rf $HOME/.local/share/icons/ssj.png &>/dev/null
rm -rf /tmp/ssj &>/dev/null
