<p align="center">Dream With Us</p>         

-----------      

开发人员       


<img src='https://github.com/moe-hacker.png?size=150'></img><a href='https://github.com/moe-hacker'>moe-hacker</a>
<img src='https://github.com/2096779623.png?size=150'></img><a href='https://github.com/2096779623'>2096779623</a>  
-----------      

[![LICENSE](https://img.shields.io/badge/license-GPLV3-brightgreen)](https://github.com/2096779623/termux-container/blob/CN/LICENSE)    [![Shell](https://img.shields.io/badge/Shell-100%25-brightgreen)](https://baike.baidu.com/item/SHELL%E8%AF%AD%E8%A8%80/22710978?fr=aladdin)      
&emsp;年轻人的第一个开源项目。    
&emsp;汉化 BY [2096779623](https://github.com/2096779623)    
&emsp;此脚本用于在termux中运行chroot系统，赛博朋克风格灵感来自一加赛博朋克联名开机动画。     
> &emsp;chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux。      
### 使用教程:    

#### 复制rootfs下载链接      
&emsp;推荐使用lxc镜像，链接:[lxc-images](https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images)      
&emsp;找到你想使用的发行版目录，然后顺着目录找到arm64版的rootfs.tar.xz的链接。              
&emsp;注：推荐新手使用ubuntu，网上有关信息可能多些 :-)      
### 安装并配置此脚本            
#### 安装:
```sh
pkg install curl pv
bash -c "$(curl -L https://raw.fastgit.org/Moe-hacker/termux-container/main/containerCN)"
container configure
```
# 用法：
```shell
 containerCN                   #运行容器
 containerCN -c                #新建容器
 containerCN -S                #选择已有容器
 containerCN -s                #设置
 containerCN -r                #删除容器
 containerCN -m                #挂载容器镜像
 containerCN -un               #解除容器挂在
 containerCN -bk               #备份容器
 containerCN -R [备份文件]      #还原容器
 containerCN -up               #更新此脚本
 containerCN -h                #显示帮助信息

```
### 交个官方作业：      
![image](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-ubuntu.jpg)
系统ubuntu，链接：      
https://share.weiyun.com/6sSwpBW8      
解压后为16G镜像文件，建议先执行fsck.ext4一下。     
### BUGS：      
&emsp;目前已知可能有些设备ping无法使用，不过据说影响不大。      
&emsp;archlinux中fakeroot需自行编译，否则yay的buildpkg环节会报错。      
&emsp;执行脚本时可能会出现sed: invalidoption -- 'xxx'
### 说明:            
&emsp;作者借鉴andrax的启动脚本写了这个脚本的container-run部分，故整个项目采用相同许可证。andrax项目链接：[andrax](https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2)      
### 背景：
&emsp;虽然已经有大佬写过支持chroot运行linux的脚本了，但是我感觉不太符合我自己的要求，也不能自由配置容器目录，主机名，使用img镜像等，这个脚本主要是想使得配置更加自由，符合个人的要求，之前在ut群水的时候偶然间发现群友发的andrax的启动脚本的一张截图，就想到了基于那个脚本写一个chroot脚本，然后找了半天，终于在gitlab上找到了，于是就有了container(太草了)。
## 免责申明：        
> 此程序"无任何担保"。          
> 此项目采用GPL V3协议开源          
> 使用此项目，您必须同意以下几点(并不过分)的要求：             
> &emsp;① 由此程序带来的任何形式的损失，开发者概不负责。      
> &emsp;② 不建议您恶意利用此程序，如使用此程序运行kali系统进行恶意攻击等，此程序给您带来的任何法律责任，开发者概不负责。      
> &emsp;③ 开发者并未在此程序中写入恶意代码，此程序所执行的一切命令系您自愿。      

-------     
<p align="center">Do Great Things</p>       
