<p align="center">Dream with me.</p>         
<p align="center">全ては筋書き通りだって</p>      
----------      
#交个官方作业：      
![avatar](https://github.com/Moe-hacker/termux-container/raw/main/screenshot.jpg)
系统ubuntu，计划等着精简下，清一下垃圾传度盘      
# 使用教程:    

### 复制rootfs下载链接,推荐使用lxc镜像，链接:     
https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images      
找到你想使用的发行版→你想使用的版本→arm64目录→default目录→日期最新的一个目录，然后复制rootfs.tar.xz的链接      
注：推荐新手使用Ubuntu       
### 安装并配置此脚本      
--------      
## 安装:
```shell
pkg install git wget tsu git e2fsprogs 
git clone https://github.com/Moe-hacker/termux-container
cd termux-container
mv container /data/data/com.termux/files/usr/bin
chmod +x /data/data/com.termux/files/usr/bin/container
cd ..
rm -rf termux-container
```
## 配置:      
```sh
container configure
```
注：建议安装后配合这位大佬的脚本食用，更适合小白
https://gitee.com/mo2/linux
# 说明:      
此脚本用于在termux中运行chroot系统      
chroot系统限制更少，速度更快，但由于没有文件隔离并不安全      
作者是萌新，借鉴andrax的启动脚本写了这个脚本，出bug请见谅      
andrax项目链接：      
https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2      
借鉴的文件：      
arm/start_andrax      
## 背景
虽然已经有大佬写过支持chroot运行linux的脚本了，但是我感觉不太符合我自己的要求，也不能自由配置容器目录，主机名，使用img镜像等，于是这个项目很早前就开始写了，当时貌似是个三天假期，我一个萌新，听着鹿乃的この世界を愛したい，写了半天，终于搞出来一个还全是bug的版本，当时只是用来运行archlinux的，后来刷机失败，脚本被毁，只剩一张截图了，后来重写了一遍，不过几乎没有变更。直到暑假，才有时间写了一个像模像样的东西。暑假这版本早期全是bug，现在修的差不多了，主要是自用，也没指望有啥用户。
