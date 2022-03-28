<p align="center">Dream With Me</p>        
<p align="center">(>_×)</p> 

-----------      

&emsp;年轻人的第一个开源项目。      
&emsp;此脚本用于在termux中运行chroot系统。     
> &emsp;chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux。      

### 使用教程(需要root权限):               
#### 安装:
```sh
pkg install curl pv
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/container-zh)"
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
## BUGS:        
&emsp;archlinux中fakeroot需自行编译，否则yay的buildpkg环节会报错,[解决方案](https://gitee.com/mo2/linux/issues/I294GU)

## 免责申明：        
> 此程序"无任何担保"。          
> 此项目采用GPL V3协议开源          
> 使用此项目，您必须同意以下几点(并不过分)的要求：             
> &emsp;① 由此程序带来的任何形式的损失，开发者概不负责。      
> &emsp;② 不建议您恶意利用此程序，如使用此程序运行kali系统进行恶意攻击等，此程序给您带来的任何法律责任，开发者概不负责。      
> &emsp;③ 开发者并未在此程序中写入恶意代码，此程序所执行的一切命令系您自愿。      

-------     
<p align="center">Do Great Things</p>       
