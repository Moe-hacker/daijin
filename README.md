<p align="center">Do Great Things</p>         

--------
# 教程:    
### ①安装必须软件
```sh
pkg install wget tsu
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
配置文件位于/data/data/com.termux/files/usr/etc/container.conf      
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
## 用法:
sudo container :运行Chroot容器      
sudo container umount :解除系统挂载      
container help :显示帮助信息      
