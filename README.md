<p align="center">May The Force Be With You</p>
<p align="center">(>_×)</p>         

-----------                   

![](https://img.shields.io/github/stars/Moe-hacker/termux-container)
![](https://img.shields.io/github/forks/Moe-hacker/termux-container)
![](https://img.shields.io/github/license/Moe-hacker/termux-container)
![](https://img.shields.io/badge/language-shell-green)

[[简体中文]](https://github.com/Moe-hacker/termux-container/blob/main/README-ZH.md)

### About:      
Termux-container is a script that runs Linux containers on your android phone. It's safe, easy to use and well-designed.      
### Screenshots:      

### Preparation:      
To run it,you need:      
- An Android phone with or without root.      
- Enough spare space.      
- Termux.      
- Some knowledge of Linux.      
### Installation:      
You can build the package from source or use the released package file.      
##### To build it from source:      
```sh
git clone https://github.com/Moe-hacker/termux-container
cd termux-container/package
chmod -R 755 DEBIAN
chmod 777 data/data/com.termux/files/usr/bin/container
dpkg -b . ~/termux-container.deb
apt update
apt install ~/termux-container.deb
```
##### To use the released package:      
Just download termux-container-v8.0.deb and install it by running:      
```
apt install ./termux-container-v8.0.deb
```
### Creating and running a container:      
You can create a container by running "container -c" and run it by running "container -run". Here are the detailed steps:    
- Run "container -c".      
- Choose the run mode of the container. If your device is not rooted,just choose proot. If your device is rooted,it is recommended to run containers with chroot-unshare mode. Don't worry about the safety of your device  —— thanks to the namespace features of Linux kernel, it's safe to run containers with unshare. You can even run "rm -rf /*" in containers when /sdcard is not mounted. (However, I don't suggest you to remove a container by using this way.) But do not use chroot-unshare containers for server —— you should compile the kernel of your device and use docker instead.       
- Name the container.      
- Enter the path of container. If you choosed proot, just use a directory in /data/data/com.termux/files/home. If you choosed chroot-unshare,it is recommended to use a directory in /data. Anyway, don't use directory in /sdcard,or you might run into problems. The container directory will be created by this script automatically, and don't create it by yourself first.      
- If you choosed chroot-unshare container, the script will ask if you'd like to install the container in an image file. If you are not sure, just choose "no".      
- Choose how to get the rootfs of container. You can use the script to download the latest rootfs from lxc and parrotOS mirrors automatically. Or you can use custom rootfs.      
- After creating a container, you can start it by running "container -run", but if your device crashed after running chroot-unshare containers, you shoud use "container -l" to run it. Legacy mode runs a common chroot container without unshare, it might work, but it's not safe.      
### Customisation:      
You can edit the global configuration of containers by running "container -s", the configuration file is written with comments. But don't edit container's configuration file if you don't know what you are doing.      
### Other usage:      
```
 container                   #Show menu.
 container -run              #Run container.
 container -l                #Run container(legacy mode). *only for chroot containers.
 container -c                #Creat a new container.
 container -S                #Switch container.
 container -s                #Settings.
 container -r                #Remove a container.
 container -m                #Mount image file. *Only for chroot-unshare containers.
 container -bk               #Backup container.
 container -R [backup file]  #Restore container.
 container -e [function name]#Exec function. *Only for debugging.
 container -v                #Display version.
 container -U                #Remove all containers&Uninstall.
```
### About me:            
I'm a senior high school student in China and dream to be a geek. If my work helps, please give me a star, thanks!       

--------
<p align="center">Try Everything</p>         
