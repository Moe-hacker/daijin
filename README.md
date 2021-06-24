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
SELINUX=[on/off] 是否关闭SELinux，不建议关闭，会使手机变得不安全，但是由于安卓系统的读取限制，在容器中普通用户可能无法正常使用，此时可通过关闭SELinux(临时关闭，重启还原)解决      
HOSTNAME=你的主机名      
OUTPUT=[on/off] 是否启用脚本输出      
SLEEP=[on/off] 是否启用停顿，如果你嫌运行太快，可以开启此选项，每条输出后停顿0.3秒      
示例：      
CHROOT_DIR=/example SELINUX=on HOSTNAME=Moe-hacker OUTPUT=on SLEEP=on      
上述配置即：容器目录为/example 启用SELinux 主机名为Moe-hacker 启用脚本输出 启用停顿        
## 用法:
sudo container :运行Chroot容器      
sudo container umount :解除系统挂载      
container help :显示帮助信息      
