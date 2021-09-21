<p align="center">Dream with me.</p>         

-----------      
&emsp;年轻人的第一个开源项目。      
&emsp;此脚本用于在termux中运行chroot系统，赛博朋克风格灵感来自一加赛博朋克联名开机动画。     
> &emsp;chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux。      
### 使用教程:    

#### 复制rootfs下载链接      
&emsp;推荐使用lxc镜像，链接:[lxc-images](https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images)      
&emsp;找到你想使用的发行版目录，然后顺着目录找到arm64版的rootfs.tar.xz的链接。        
&emsp;一定要是rootfs.tar.xz，如果你是大佬，自己解压然后看wiki写配置文件也可以        
&emsp;注：推荐新手使用ubuntu，网上有关信息可能多些 :-)      
### 安装并配置此脚本            
#### 安装:
```sh
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/install.sh)"
container configure
```
更多帮助文档请查看wiki：      
### [termux-container wiki](https://github.com/Moe-hacker/termux-container/wiki)
### 交个官方作业：      
![image](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot-ubuntu.jpg)
系统ubuntu，链接：      
https://share.weiyun.com/6sSwpBW8      
解压后为16G镜像文件，建议先执行fsck.ext4一下。     
### BUGS：      
&emsp;目前已知可能有些设备ping无法使用，不过据说影响不大。      
&emsp;archlinux中fakeroot需自行编译，否则yay的buildpkg环节会报错。      
### 脚本结构：      
```sh
termux-container
├── container #主脚本，安装时被复制存放在/data/data/com.termux/files/usr/bin中，调用termux-container目录中的子脚本，执行时会自动获取root权限
├── container-configure #用于配置此脚本并解压rootfs
├── container-echo #没用的输出
├── container-help #帮助信息
├── container-mount #用于挂载镜像但不运行chroot
├── container-run #用于挂载系统并运行chroot
├── container-unmount #用于解除系统挂载
├── container-update #用于更新此项目
├── install.sh #用于此项目安装
├── LICENSE #许可证
├── old #存放之前的老版本
│   └── container #老版本的脚本，多合一，输出为彩色而非全红，没有赛博朋克特效
└── README.md #github的readme文档
```
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
> &emsp;(建议你在运行前阅读此项目代码，我应该都写注释了)            

-------     
<p align="center">そよ風になびく君の髪、</p>       
<p align="center">  想いよ 君へ届け。</p>    
