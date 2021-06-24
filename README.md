<p align="center">Do Great Things</p>         

--------
## 安装:
```sh
pkg install tsu
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
CHROOT_DIR=/example      
SELINUX=on       
HOSTNAME=Moe-hacker       
OUTPUT=on        
SLEEP=on      
上述配置即：    
容器目录为/example       
启用SELinux       
主机名为Moe-hacker       
启用脚本输出       
启用停顿        
## 用法:
sudo container :运行Chroot容器      
sudo container umount :解除系统挂载      
container help :显示帮助信息      
