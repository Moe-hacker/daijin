<p align="center">May The Force Be With You</p>
<p align="center">(>_×)</p>         
<p align="center">Moe-hacker</p>

-----------        
[[简体中文]](https://github.com/Moe-hacker/termux-container/blob/main/README-ZH.md)           


&emsp;Run Linux with chroot command on your Android phone!      
&emsp;This is a script that runs a Linux system on your phone.You are free to define this script and make it to be you want.      
&emsp;In the chroot environment,you can do more things than Android,because it is a real Linux system.You can run a desktop and connect it with Realvnc Viewer,or you can just use the shell for programming or hacking.(But DO NOT against the laws!)
### Notes:      
> Chroot is faster than proot with less limits.But it can only be run with root privileges,and it is dangerous.If you do not want to run programs that must be able to read/write the files in /proc but using a common user,please do not disable SELinux.      
### Screenshot:
![screenshot](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-install.jpg)
![screenshot](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-run.jpg)
### Preparation:      
&emsp;To run it,you need：      
- A phone with root       
- Enough spare space      
- [Termux](https://termux.org)       
- Some knowledge of Linux      
### Installation:
```sh
pkg install curl pv wget
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/container)"
```
Enjoy it!     
### Usage:
```shell
 container -run              #Run container
 container -c                #Creat a new container
 container -S                #Select a container
 container -s                #Settings
 container -r                #Remove a container
 container -m                #Mount image file
 container -un               #Unmount container
 container -bk               #Backup container
 container -R [backup file]  #Restore container
 container -up               #Update this script
 container -h                #Show helps
```
### Bugs      
&emsp;If you are using Archlinux,maybe fakeroot is unavailable.      
### About:      
&emsp;I used some of the source code in [andrax](https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2) and [Tmoe-linux](https://gitee.com/mo2/linux) to finish this script,so I choosed the same license to publish it.      
&emsp;I'm sorry that my English is not very well.If there are any mistakes in this document,please tell me.      
&emsp;This is my first repository on Github and this is the start of my dream of being a geek.If you like it,please give me a star,thanks!       

--------
<p align="center">Try Everything</p>         
