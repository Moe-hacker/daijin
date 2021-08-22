<p align="center">Dream with me.</p>         
<p align="center">如果结果不如你所愿，就在尘埃落定前奋力一搏</p>        

此脚本用于在termux中运行chroot系统，赛博朋克风格灵感来自一加赛博朋克联名开机动画     
chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux      
### 使用教程:    

#### 复制rootfs下载链接,推荐使用lxc镜像，链接:     
https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images      
找到你想使用的发行版目录，然后顺着目录找到arm64版的rootfs.tar.xz的链接        
一定要是rootfs.tar.xz，否则无法解压，后续可能会支持gz版本        
注：推荐新手使用Ubuntu       
### 安装并配置此脚本            
#### 安装:
```sh
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/install.sh)"
```
更多帮助文档请查看
```sh
container help
```
### 交个官方作业：      
![avatar](https://github.com/Moe-hacker/termux-container/raw/main/.Screenshots/screenshot.jpg)
系统ubuntu，链接      
https://share.weiyun.com/6sSwpBW8      
解压后为16G镜像文件     
# 说明:            
作者是萌新，借鉴andrax的启动脚本写了这个脚本的container-run部分      
andrax项目链接：      
https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2      
## 背景
虽然已经有大佬写过支持chroot运行linux的脚本了，但是我感觉不太符合我自己的要求，也不能自由配置容器目录，主机名，使用img镜像等，这个脚本主要是想使得配置更加自由，符合每个人的要求，但可惜bug太多了。
# 免责申明：        
此项目采用GPL V3协议开源          
使用此项目，您默认同意以下几点：          
此程序"无任何担保"       
此程序作者"无义务维护此项目"      
① 由此程序带来的任何形式的损失，开发者概不负责      
② 不建议您恶意利用此程序，如使用此程序运行kali系统进行恶意攻击等，此程序给您带来的任何法律责任，开发者概不负责      
③ 开发者并未在此程序中写入恶意代码，此程序所执行的一切命令系您自愿      
(建议你在运行前阅读此项目代码)      
GPL-V3中赋予您的四项基本自由：      
不论目的为何，有运行该软件的自由（自由之零）。      
有研究该软件如何工作以及按需改写该软件的自由（自由之一）。    
有重新发布拷贝的自由，这样你可以借此来敦亲睦邻（自由之二）。      
有向公众发布改进版软件的自由（自由之三）。      
更多信息，请访问http://www.gnu.org/      
