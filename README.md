# SSJ - Your everyday Linux distribution gone Super Saiyan.

![ssj](https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png)

## Introduction

SSJ is a silly little script that makes use of [Docker](https://www.docker.com/) installed on your everyday Linux distribution (Ubuntu, Debian, etc.) and magically arms it with hundreds of penetration testing and forensics tools.

## Technical Details

SSJ pulls a Docker image that uses [Kali Linux](https://www.kali.org/) base image,`kalilinux/kali` and installs `kali-linux-large` metapackage over it. It uses the `kali.download/kali` mirror and `kali-last-snapshot` branch. It also allows you to run GUI applications like Burpsuite, Wireshark, Ettercap, etc. from within the container on your everyday Linux distribution by using `--privileged` container capabilities and adding a universal access control to `xhost` on your host Linux distribution. This script creates a `.desktop` file (the Application Launcher) for you that initiates the `docker run` command to run the container. So, the only thing you need to do is, find SSJ in you applicaiton drawer or menu and click on it to launch it. A `terminator` window will popup with all your pentesting and forensics tools in it. Execute `burpsuite` to fire up the proxy, `wireshark` to fire up the packet analyzer and like that, you have access to hundreds of tools and packages that are there in Kali Linux (particularly the `kali-linux-large` metapackage), right on your everyday Linux distribution. Also, contrary to virtual machines, that are either networked behind a virtual NAT or bridged along with the host operating system, SSJ utilizes the host network stack as it is (using `--net=host`) which means that the SSJ container will have direct access to all the network interfaces as the host Linux distribution and will also share the same IP address.

## Prerequisites
+ Docker (User must be in the `docker` group)
+ Internet connection

## Installation

`mkdir -p /tmp/ssj && wget https://raw.githubusercontent.com/thirdbyte/ssj/main/install.sh -O /tmp/ssj/install.sh && chmod +x /tmp/ssj/install.sh && sudo /tmp/ssj/./install.sh`

This might take variable time depending upon your Internet speed. It pulls the Docker image from Docker Hub that weighs around 4G.

## Usage

1. Access the application drawer/menu on your Linux distribution to find SSJ.
2. Launch SSJ.
3. A `terminator` terminal will pop up.
4. Use this terminal to launch any tool by executing them using their respective package names. For an example: `msfconsole`, `burpsuite`, `wireshark`, etc.
5. You can save any file in the `/root` directory inside the container and find it at `/home/ssj` on your host Linux distribution.

## Screenshots

**Tested on:** Ubuntu 20.04.1 LTS (GNOME), Linux Mint 20 Ulyana (Cinnamon)

**Notice**: The screenshots underneath represent `xfce4-terminal` which is now replaced with `terminator`.

![Ubuntu Application Launcher](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_application_launcher.png)

![Ubuntu Burpsuite](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_burpsuite.png)

![Ubuntu Wireshark](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_wireshark.png)

![Ubuntu Ettercap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_ettercap.png)

![Ubuntu Metasploit & Nmap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_msf_nmap.png)

![Mint Application Launcher](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_application_launcher.png)

![Mint Burpsuite](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_burpsuite.png)

![Mint Wireshark](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_wireshark.png)

![Mint Ettercap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_ettercap.png)

![Mint Metasploit & Nmap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_msf_nmap.png)

## Plugins

+ [Add Tools](https://github.com/thirdbyte/ssj-plugin-add-tools): A convenient script that lets you add more tools to SSJ that are not a part of the `kali-linux-large` metapackage.

## Updates

Since SSJ uses `kali-last-snapshot` branch of Kali Linux repositories, you don't need to update it until a new snapshot version (`2020.1`, `2020.2`, `2020.3`, etc.) of Kali Linux gets released. Once, a new version gets released, redo the [installation](https://github.com/thirdbyte/ssj#installation) and if you are using [Add Tools](https://github.com/thirdbyte/ssj-plugin-add-tools) plugin, you'll need to re-execute the `add-tools` script as well.

## Troubleshooting

+ Since the container runs with the root user privileges, the files created in the `/root` directory have the owner set to root. On the host Linux distribution, this directory is `/home/ssj`. All the files and sub directories inside `/home/ssj` will require the root user of the host Linux distribution in case any data needs to be written to or deleted from this directory.

## Limitations

+ Wireless hacking tools that require a patched kernel, the one that you'd find in Kali Linux, will not work on SSJ. The simple reason for this is the fact that SSJ utilizes the Linux kernel of your host Linux distribution which isn't patched or modified to support packet injection.
+ SSJ uses Docker's `--privileged` container capabilities and `--net=host` networking. It also adds a universal access control to `xhost` for making GUI applications work, but immidiately closes it once SSJ's `terminator` is exited. This might allow any application to access the X server or GUI of your host Linux distribution in particular for the time SSJ is running which can be a security or a privacy concern for many.
+ Audio ouput does not work as of now.

## Uninstallation

`mkdir -p /tmp/ssj && wget https://raw.githubusercontent.com/thirdbyte/ssj/main/uninstall.sh -O /tmp/ssj/uninstall.sh && chmod +x /tmp/ssj/uninstall.sh && sudo /tmp/ssj/./uninstall.sh`

## And...

This script was created out of curiosity. This might solve a lot of problems. This might create new ones as well. It comes with no commitments whatsoever. You may do anything you wish to do with this script and are solely responsible for it. You can still feel free to file issues in case you experience any of them. Cheers!
