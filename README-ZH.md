<p align="center">Dream With Me</p>        
<p align="center">(>_×)</p> 

-----------      

&emsp;年轻人的第一个开源项目。      
&emsp;此脚本用于在termux中运行chroot系统。     
> &emsp;chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux。      

注：如果想研究本项目可以查看container_core，是这个项目的核心代码，没有输出等花里胡哨的东西
### 使用教程(需要root权限):               
#### 安装:
```sh
pkg install curl pv
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/container)"
```
# 用法：
```shell
 container -run              #Run container
 container -c                #Creat a new container
 container -S                #Switch a container
 container -s                #Settings
 container -r                #Remove a container
 container -m                #Mount image file
 container -un               #Unmount container
 container -bk               #Backup container
 container -R [backup file]  #Restore container
 container -up               #Update this script(obsolete)
 container -v                #Show version
 container -U                #Uninstall this script
 container -h                #Show helps

```
### BUGS：      
&emsp;目前已知可能有些设备ping无法使用，解决方案:在容器中运行group_add.sh     
&emsp;archlinux中fakeroot需自行编译，否则yay的buildpkg环节会报错,[解决方案](https://gitee.com/mo2/linux/issues/I294GU)      
咕咕咕………………
### 说明:            
&emsp;作者借鉴andrax的启动脚本写了这个脚本的container_run部分，故整个项目采用相同许可证。andrax项目链接：[andrax](https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2)      
### 背景：
&emsp;虽然已经有大佬写过支持chroot运行linux的脚本了，但是我感觉不太符合我自己的要求，也不能自由配置容器目录，主机名，使用img镜像等，这个脚本主要是想使得配置更加自由，之前在ut群水的时候偶然间发现群友发的andrax的启动脚本的一张截图，就想到了基于那个脚本写一个chroot脚本，于是就有了container(太草了)。
## 免责申明：        
> 此程序"无任何担保"。          
> 此项目采用GPL V3协议开源          
> 使用此项目，您必须同意以下几点(并不过分)的要求：             
> &emsp;① 由此程序带来的任何形式的损失，开发者概不负责。      
> &emsp;② 不建议您恶意利用此程序，如使用此程序运行kali系统进行恶意攻击等，此程序给您带来的任何法律责任，开发者概不负责。      
> &emsp;③ 开发者并未在此程序中写入恶意代码，此程序所执行的一切命令系您自愿。      

-------     
<p align="center">Do Great Things</p>       
