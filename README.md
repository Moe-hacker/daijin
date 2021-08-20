<p align="center">Dream with me.</p>         

----------      
刚说收官就看到了issue，看来还得更(受虐滑稽)        
----------         
此脚本用于在termux中运行chroot系统     
chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux      
# 截图    
![image](https://github.com/Moe-hacker/termux-container/raw/main/Screenshot_2021-08-02-18-31-23-788_com.termux.jpg)
![image](https://github.com/Moe-hacker/termux-container/raw/main/Screenshot_2021-08-02-18-31-55-299_com.termux.jpg)
----------      
# 交个官方作业：      
![avatar](https://github.com/Moe-hacker/termux-container/raw/main/screenshot.jpg)
系统ubuntu，链接      
https://share.weiyun.com/6sSwpBW8      
解压后为16G镜像文件     
----------      
# 使用教程:    

## 复制rootfs下载链接,推荐使用lxc镜像，链接:     
https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images      
找到你想使用的发行版目录，然后顺着目录找到arm64版的rootfs.tar.xz的链接        
一定要是rootfs.tar.xz，否则无法解压，后续可能会支持gz版本        
注：推荐新手使用Ubuntu       
## 安装并配置此脚本            
### 安装:
```shell
curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/install.sh|bash
```
更多帮助文档请查看
```sh
container help
```
# 说明:            
作者是萌新，借鉴andrax的启动脚本写了这个脚本，出bug请见谅      
andrax项目链接：      
https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2      
借鉴的文件：arm/start_andrax      
## 背景
虽然已经有大佬写过支持chroot运行linux的脚本了，但是我感觉不太符合我自己的要求，也不能自由配置容器目录，主机名，使用img镜像等，这个脚本主要是想使得配置更加自由，符合每个人的要求，至于bug，我还想吐槽呢。
