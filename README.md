<p align="center">Dream with me.</p>         

--------
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
pkg install git
git clone https://github.com/Moe-hacker/termux-container
cd termux-container
mv container /data/data/com.termux/files/usr/bin
chmod +x /data/data/com.termux/files/usr/bin/container
touch /data/data/com.termux/files/usr/etc/container.conf
cd ..
rm -rf termux-container
```
## 配置:      
```sh
container configure
```
# 说明:      
作者是萌新，借鉴andrax的启动脚本写了这个脚本      
andrax项目链接：      
https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2      
借鉴的文件：      
arm/start_andrax      
