<p align="center">Do Great Things</p>         

--------
# 教程:    
### ①安装必须软件
```sh
pkg install wget tsu git
```  
### ②在/data下创建容器目录      
```shell
sudo mkdir /data/你的容器目录
```
例如：容器目录为example，则      
```shell
sudo mkdir /data/example
```
### ③下载系统rootfs,推荐使用lxc镜像，链接:     
https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images      
找到你想使用的发行版→你想使用的版本→arm64目录→default目录→日期最新的一个目录，然后复制rootfs.tar.xz的链接      
注：推荐新手使用Ubuntu      
```shell
wget 你刚复制的链接
```
### ④解压系统rootfs      
```shell
sudo tar -xvf rootfs.tar.xz -C /data/你的容器目录
```
### ⑤安装并配置此脚本      
--------

## 安装:
```shell
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
配置文件位于      
/data/data/com.termux/files/usr/etc/container.conf      
内容：      
CHROOT_DIR=容器的绝对路径      
SELINUX=[on/off] 是否关闭SELinux       
HOSTNAME=你的主机名      
OUTPUT=[on/off] 是否启用脚本输出      
SLEEP=[on/off] 是否启用停顿        
示例：      
CHROOT_DIR=/data/example SELINUX=on HOSTNAME=Moe-hacker OUTPUT=on SLEEP=on      
上述配置即：    
容器目录为/data/example       
启用SELinux       
主机名为Moe-hacker       
启用脚本输出       
启用停顿        
```
## 用法:
```sh
sudo container :运行Chroot容器      
sudo container umount :解除系统挂载      
container help :显示帮助信息    
```  
# FAQ      
#### ①如果无法运行：
运行chroot需要root权限，华为，vivo等无法root的手机要么某宝，要么出门左拐是proot谢谢     
#### ②为什么要关闭SELinux：      
由于Android的访问限制，普通用户无法读写/proc下的大部分内容，所以若是在容器中使用普通用户会出现一些bug，此时可通过关闭SELinux解决      
#### ③sudo无法使用      
通过重新挂载/data分区为suid，理论上可以解决，但是在我的k40pro上测试，并不起作用      
我将会研究如何讲系统安装在镜像文件中，以此解决这个问题            
# 说明:      
作者只是个小萌新，借鉴andrax的启动脚本创作了此脚本。      
andrax项目链接：      
https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2      
借鉴的文件：      
arm/start_andrax      
