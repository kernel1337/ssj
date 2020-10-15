# SSJ - Your everyday Linux distribution gone Super Saiyan.
![ssj](https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png)

## Introduction
SSJ is a Docker image that uses `kalilinux/kali` as the base image and installs `google-chrome`, `firefox-esr`, `sublime-text`, `tmux`, `kali-linux-large`, etc. packages. It uses the `kali.download/kali` as the mirror and `kali-last-snapshot` branch. It also allows you to run GUI applications like Burpsuite, Wireshark, Ettercap, etc. from within the container on your everyday Linux distribution. This script will build the image and create a .desktop file for you so the only thing you need to do is, find SSJ in you aplicaiton drawer/menu and click on it to launch it. An `xfce4-terminal` will popup with all your pentesting and infosec tools in it. Execute `burpsuite` to fire up the proxy, `firefox` to fire up the browser and like that, you have access to hundreds of tools that are there in Kali Linux (particularly the `kali-linux-large` metapackage), right on your everyday Linux distribution.

This script is just an extension to [demon-docker](https://github.com/thirdbyte/demon-docker). SSJ goes a few steps ahead to make the setup easy and convenient for you. 

## Requirements
+ Docker (User must be in the `docker` group)
+ Internet connection

## Installation
`curl -L ssjd.tk > ssj.sh && chmod +x ssj.sh && sudo ./ssj.sh`

This might take half an hour to full depending upon your Internet speed. The script needs to download 3-4G of data.

## Usage
1. Access the application drawer/menu on your Linux distribution to find SSJ.
2. Launch SSJ.
3. An `xfce4-terminal1` will pop up.
4. Use this terminal to launch any tool by executing them using their respective package names. For an example: `msfconsole`, `burpsuite`, `chromium`, `wireshark`, etc.
5. You can save any file in the `/root` directory inside the container and find it at `/home/ssj` on your host Linux distribution.

## Screenshots

**Tested on:** Ubuntu 20.04.1 LTS

![Application Launcher](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ssj_ss_application_launcher.png)

![Burpsuite](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ssj_ss_burpsuite.png)

![Wireshark](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ssj_ss_wireshark.png)

![Ettercap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ssj_ss_ettercap.png)

![Metasploit & Nmap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ssj_ss_msf_nmap.png)

## Troubleshooting
+ The Kali Linux repositories are updated very frequently. Sometimes, when the packages are being migrated to the `/kali` repository, you might get a `404` error finding some packages while the image is building. The only way to resolve this as of now is to wait a few hours and try again.

## Limitations
+ Wireless hacking tools that require a patched kernel, the one that is found in Kali Linux, will not work on SSJ. The simple reason for that is SSJ utilizes the Linux kernel of your host machine which isn't patched or modified to support packet injection.
+ SSJ uses docker `--privileged` capabilities and `--net=host`. It also adds a universal access control to `xhost` for making GUI applications work, but immidiately closes it once you ext SSJ's `xfce4-terminal` is exited. This might allow any application to access the X server or GUI in particular for the time SSJ is running. This can be a security or a privacy concern for many.
+ Audio ouput does not work as of now.
+ Since the container runs with the root user, the files created in the `/root` directory have the owner set to root. On the host, this directory is `/home/ssj`. All the files and sub directories inside `/home/ssj` will require the root user on the host in case any data needs to be written to or deleted from this directory.
