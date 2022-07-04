<p align="center">Dream With Me</p>        
<p align="center">(>_×)</p> 

-----------      

&emsp;年轻人的第一个开源项目。      
&emsp;此脚本用于在termux中运行unshare&chroot或proot系统。     
> &emsp;chroot系统限制更少，速度更快，在unshare后有一定安全性，不过为防止误删请勿挂载/sdcard到容器，否则可能导致数据丢失。非特殊情况请勿关闭SELinux!      

### 安装教程:             
```sh
git clone https://github.com/Moe-hacker/termux-container
cd termux-container/package-zh
chmod -R 755 DEBIAN
chmod 777 data/data/com.termux/files/usr/bin/container
dpkg -b . ~/termux-container.deb
apt update
apt install ~/termux-container.deb
```
## 免责申明：        
> 此程序"无任何担保"。          
> 此项目采用Apache2协议开源          
> 使用此项目，您必须同意以下几点(并不过分的)要求：             
> &emsp;① 由此程序带来的任何形式的损失，开发者概不负责。      
> &emsp;② 不建议您恶意利用此程序，如使用此程序运行kali系统进行恶意攻击等，此程序给您带来的任何法律责任，开发者概不负责。      
> &emsp;③ 开发者并未在此程序中写入恶意代码，此程序所执行的一切命令系您自愿。      
> &emsp;④ 开发者并无义务对此仓库进行更新维护。

-------     
<p align="center">Do Great Things</p>       
