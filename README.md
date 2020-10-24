# SSJ - Your everyday Linux distribution gone Super Saiyan.
![ssj](https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj.png)

## Introduction
SSJ is a silly little script that makes use of [Docker](https://www.docker.com/) installed on your everyday Linux distribution (Ubuntu, Debian, etc.) and magically arms it with hundreds of penetration testing and forensics tools. All of these run with almost native performance (as containers utilize the host operating system's kernel) and thus is a slightly better alternative to Virtual Machines in terms of speed, performance and convenience.

## Technical Details
SSJ is a Docker image that uses [Kali Linux](https://www.kali.org/) base image,`kalilinux/kali` and installs `kali-linux-large` metapackage over it. It uses the `kali.download/kali` mirror and `kali-last-snapshot` branch. It also allows you to run GUI applications like Burpsuite, Wireshark, Ettercap, etc. from within the container on your everyday Linux distribution by using `--privileged` container capabilities and adding a universal access control to `xhost`. This script pulls/builds the Docker image and creates a `.desktop` file (the Application Launcher) for you that initiates the runs the container. So, the only thing you need to do is, find SSJ in you aplicaiton drawer/menu and click on it to launch it. A `terminator` terminal will popup with all your pentesting and forensics tools in it. Execute `burpsuite` to fire up the proxy, `wireshark` to fire up the packet analyzer and like that, you have access to hundreds of tools and packages that are there in Kali Linux (particularly the `kali-linux-large` metapackage), right on your everyday Linux distribution. Also, contrary to virtual machines, that are either networked behind a virtual NAT or bridged along with the host operating system, SSJ utilizes the host network stack as it is (using `--net=host`) which means that the SSJ container will have direct access to all the network interfaces as the host Linux distribution and will also share the same IP address.

## Prerequisites
+ Docker (User must be in the `docker` group)
+ Internet connection

## Installation
**Quick Install:**

`wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj_quick.sh -O /tmp/ssj.sh && chmod +x /tmp/ssj.sh && sudo /tmp/./ssj.sh`

This might take variable time depending upon your Internet speed. It pulls the Docker image from Docker Hub that weighs around 4G. This method is still faster, cetain and recommended.

OR

**Build Install:**

`wget https://raw.githubusercontent.com/thirdbyte/ssj/main/ssj_build.sh -O /tmp/ssj.sh && chmod +x /tmp/ssj.sh && sudo /tmp/./ssj.sh`

This might take variable time depending upon your Internet speed. It builds the image locally which requires downloading of all the packages in `kali-linux-large` metapackage that weigh around 3G to 4G. This method is slower, uncertain and not recommended but might make sense in case a user does not trust pre-built Docker Hub images.

## Usage
1. Access the application drawer/menu on your Linux distribution to find SSJ.
2. Launch SSJ.
3. A `terminator` terminal will pop up.
4. Use this terminal to launch any tool by executing them using their respective package names. For an example: `msfconsole`, `burpsuite`, `wireshark`, etc.
5. You can save any file in the `/root` directory inside the container and find it at `/home/ssj` on your host Linux distribution.

## Plugins
+ [Add Tools](https://github.com/thirdbyte/ssj-plugin-add-tools): A convenient script that lets you add more tools to SSJ that are not a part of the `kali-linux-large` metapackage.

## Screenshots

**Tested on:** Ubuntu 20.04.1 LTS (GNOME), Linux Mint 20 Ulyana (Cinnamon)

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

## Troubleshooting
+ Being a rolling-release distribution, Kali Linux's repositories are updated very frequently. Sometimes, when the packages are being migrated to the pool, you might get a `404` error finding some packages while trying to build the image or install SSJ using the Build Install command. The only way to resolve this as of now is to either wait a few hours and try again, or install SSJ using the Quick Install command.
+ Since the container runs with the root user privileges, the files created in the `/root` directory have the owner set to root. On the host Linux distribution, this directory is `/home/ssj`. All the files and sub directories inside `/home/ssj` will require the root user of the host Linux distribution in case any data needs to be written to or deleted from this directory.

## Why use SSJ?
+ Requires lesser amount of disk space (around 10G) as compared to a VM.
+ Faster and more convenient than a VM.
+ Everything runs as if it is running on your host Linux distribution both in terms of performance and experience.
+ SSJ is isolated from host Linux distribution in terms of filesystem (except `/root` which is mounted from `/home/ssj` on the host Linux distribution) and processes. This means that whatever you do inside the SSJ container will not interfere with anything on your host Linux distribution.


## Limitations
+ Wireless hacking tools that require a patched kernel, the one that you'd find in Kali Linux, will not work on SSJ. The simple reason for this is the fact that SSJ utilizes the Linux kernel of your host Linux distribution which isn't patched or modified to support packet injection.
+ SSJ uses Docker's `--privileged` container capabilities and `--net=host` networking. It also adds a universal access control to `xhost` for making GUI applications work, but immidiately closes it once SSJ's `terminator` is exited. This might allow any application to access the X server or GUI of your host Linux distribution in particular for the time SSJ is running which can be a security or a privacy concern for many.
+ Audio ouput does not work as of now.

## And...
This script was created out of curiosity. This might solve a lot of problems. This might create new ones as well. It comes with no commitments whatsoever. You may do anything you wish to do with this script and are solely responsible for it. You can still feel free to file issues in case you experience any of them. Cheers!
