<p align="center">May The Force Be With You</p>
<p align="center">(>_×)</p>         
<p align="center">Moe-hacker</p>

-----------                   

![](https://img.shields.io/github/stars/Moe-hacker/termux-container)
![](https://img.shields.io/github/forks/Moe-hacker/termux-container)
![](https://img.shields.io/github/license/Moe-hacker/termux-container)
![](https://img.shields.io/badge/language-shell-green)

[[简体中文]](https://github.com/Moe-hacker/termux-container/blob/main/README-ZH.md)

&emsp;Run Linux with chroot&unshare/proot on your Android phone!      
&emsp;This is a script that runs a Linux system on your phone.You are free to define this script and make it to be you want.      
&emsp;In the chroot/proot environment,you can do more things than Android,because it is a real Linux system.You can run a desktop and connect it with Realvnc Viewer,or you can just use the shell for programming or hacking.(But DO NOT against the laws!)
### Notes:      
> Chroot is faster than proot with less limits.But it can only be run with root privileges,and it is a bit dangerous.If you do not want to run programs that must be able to read/write the files in /proc but using a common user,please do not disable SELinux.      
### Screenshots:
![screenshot](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-install.jpg)
![screenshot](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-run.jpg)
### Preparation:      
&emsp;To run it,you need：      
- An android phone.       
- Enough spare space.      
- [Termux.](https://termux.org)       
- Some knowledge of Linux.      
### Installation:
```sh
git clone https://github.com/Moe-hacker/termux-container
cd termux-container/package
chmod -R 755 DEBIAN
chmod 777 data/data/com.termux/files/usr/bin/container
dpkg -b . ~/termux-container.deb
apt update
apt install ~/termux-container.deb
```
Enjoy it!     

### About:      
&emsp;I used some of the source code in [Tmoe-linux](https://gitee.com/mo2/linux) to finish this script.   
&emsp;I'm sorry that my English is not very well.If there are any mistakes in this document,please tell me.      
&emsp;This is my first repository on Github and this is the start of my dream of being a geek.If you like it,please give me a star,thanks!       

--------
<p align="center">Try Everything</p>         
