<p align="center">Dream With Me</p>        
<p align="center">(>_×)</p> 

-----------      

![](https://img.shields.io/github/stars/Moe-hacker/termux-container)
![](https://img.shields.io/github/forks/Moe-hacker/termux-container)
![](https://img.shields.io/github/license/Moe-hacker/termux-container)
![](https://img.shields.io/badge/language-shell-green)
### 关于：      
很久很久以前(好像也就一年前？)，有一只萌新由于tmoe的容器路径太长，自己懒得输(为什么不去提个Issue呢？🤣👉)，于是写了千行代码，终于可以把容器直接安装在/data下的文件夹里了，非常完美，后来就有了这个项目，可真能水。      
~~我是懂懒的~~          
不过docker pull&docker run貌似好用多了，也用不到管理容器具体路径因为有docker cp啊😋。         
特色：      
精心设计的输出，虽然你若不喜欢可以关掉。。。。。。      
默认开启mount namespace，就算容器未被卸载也不会删除容器中挂载的系统文件。      
尽可能多的开启namespace隔离容器，不过大部分内核默认支持的namespaces有限。      
在容器运行后手动创建dev,sys和proc三个目录，/dev下磁盘设备未被映射，最起码能防手贱。。。      
rm -rf /*在/sdcard未被挂载时只会删除容器本身，宿主机由于已被隔离不会造成损坏(测试于pixel3,A12,chroot-unshare模式，不过建议别试，真寄了我也没办法)            
### 截图：      
脚本大概长这样(懒得上传中文版截图了，凑活看吧):      
![](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/Screenshot_20221012-185314_Termux.png)
![](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/Screenshot_20221012-185209_Termux.png)
### 准备工作：      
说了这么多，你是不是想试着运行一下这个项目？      
运行前准备：      
- 一部安卓手机，🍎？爬！有EL2权限的手机不配使用容器！！！！            
- Termux
- 足够的剩余空间              
- 一点Linux知识
- 🧠(非常重要)      
### 安装：      
保持最新：      
```sh
git clone https://github.com/Moe-hacker/termux-container
cd termux-container/package-zh
chmod -R 755 DEBIAN
chmod 777 data/data/com.termux/files/usr/bin/container
dpkg -b . ~/termux-container.deb
apt update
apt install ~/termux-container.deb
```
使用release:                 
下载下来apt install ./xxxx.deb也行。             
### 创建并运行容器：     
- 运行container -c                 
- 选择容器类型，有root用chroot-unshare，没有就用proot。      
- 添加一个普通用户，输入用户名密码。      
- 按提示输入容器路径。      
- 如果是chroot-unshare容器，会问你是否使用镜像文件，一般直接选择否，重构会砍掉这个功能。      
- 选择获取rootfs的方式。              
- 选择系统版本。
- 安装，等。。。。。。。      
- 运行container -run进入容器。      
注：运行chroot-unshare容器崩溃的，可使用container -l运行普通chroot容器。虽然没那么但起码能用。      
### 自定义：      
运行container -s编辑配置文件，有注释这里就不细说了，懒。。。      
### 其他用法：      
```
 container                   #打开菜单
 container -run              #运行容器
 container -l                #运行容器(传统模式) *仅供chroot容器
 container -c                #创建一个新容器
 container -S                #切换容器
 container -s                #设置
 container -r                #删除一个容器
 container -m                #挂载镜像文件 *仅供chroot容器
 container -bk               #备份容器
 container -R [备份文件]     #还原容器
 container -e [函数名]       #执行内置函数 *仅供调试
 container -v                #版本信息
 container -U                #批量删除容器&卸载此脚本
```
### 关于作者：      
两个号，逝精神分裂。         
后续猫猫负责提交和测试，主人来进行合并。          

-------     
<p align="center">Do Great Things</p>       
