<p align="center">May the force be with you.</p>         

-----------     
> &emsp;  [[简体中文]](https://github.com/Moe-hacker/termux-container/blob/main/README-ZH.md)           

&emsp;Run Linux with chroot command on your Android phone!      
&emsp;This is a script that runs a Linux system on your phone.It has a cool output,but if you do not like,you can disable it.In fact,you are free to define this script and make it to be you want to be.      
&emsp;In the chroot environment,you can do more things than Android,because it is a real Linux system.You can run a desktop and connect it with Realvnc Viewer,or you can just use the shell for programming or hacking.(But DO NOT against the laws!)
### Notes:      
> Chroot is faster than proot with less limits.But it can only be run with root privileges,and it is dangerous.If you do not want to run programs that must be able to read/write the files in /proc but using a common user,please do not disable SELinux.      
### Screenshot:
![screenshot](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-container.jpg)
![screenshot](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-container-con.jpg)
### Preparation:      
&emsp;To run it,you need：      
- A phone with root       
- Enough spare space      
- [Termux](https://termux.org)       
- Some knowledge of Linux      
### Installation:
&emsp;Copy the link to download the rootfs.I advice you to use the mirror of [lxc-images](https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images) . The architecture of rootfs must be the same as your device.   
> If you are a beginner,I think Ubuntu is better for you.        

&emsp;Then,
```sh
pkg install curl
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/install.sh)"
container configure
```
Enjoy it!
### Bugs      
&emsp;If you are using Archlinux,maybe fakeroot is unavailable.      
&emsp;On some devices,ping may be unavailable.      
&emsp;I'll try to fix them.       
&emsp;Any bugs,please report at [ISSUES](https://github.com/Moe-hacker/termux-container/issues)
### About:      
&emsp;I used some of the source code in [andrax](https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2) to finish this script,so I choosed the same license to publish it.      
&emsp;I'm sorry that my English is not very well.If there are any mistakes in this document,please tell me.      
&emsp;This is my first repository on Github and this is the start of my dream of being a geek.If you like it,please give me a star,thanks!       

--------
<p align="center">Try everything.</p>         
