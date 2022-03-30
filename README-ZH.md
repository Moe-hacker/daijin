<p align="center">Dream With Me</p>        
<p align="center">(>_×)</p> 

-----------      

&emsp;年轻人的第一个开源项目。      
&emsp;此脚本用于在termux中运行chroot系统。     
> &emsp;chroot系统限制更少，速度更快，但由于没有像docker一样的运行隔离因此并不安全，非特殊情况请勿关闭SELinux。      

### 使用教程(需要root权限):               
#### 使用container-helper一键安装系统，支持的系统有debian,fedora,alpile,parrot,ubuntu,kali,archlinux和centos,仅支持aarch64架构(一般手机都是)，适合萌新:         
```sh
git clone https://github.com/Moe-hacker/termux-container 
cd termux-container
./container-helper
```
#### 自定义安装，可使用任意手机架构支持的rootfs:
```sh
pkg install curl pv
bash -c "$(curl -L https://raw.githubusercontent.com/Moe-hacker/termux-container/main/container-zh)"
```
# 用法：
```shell
container        #启动菜单
container-helper #一键安装系统，适合萌新使用，使用此脚本安装的容器必须通过此脚本卸载
container -h     #查看命令行用法
```
注:使用helper安装的系统和container不完全兼容，因此无法通过container单个删除。      
## BUGS:        
&emsp;archlinux中fakeroot需自行编译，否则yay的buildpkg环节会报错,container-helper中的rootfs已解决此问题
## 免责申明：        
> 此程序"无任何担保"。          
> 此项目采用GPL V3协议开源          
> 使用此项目，您必须同意以下几点(并不过分)的要求：             
> &emsp;① 由此程序带来的任何形式的损失，开发者概不负责。      
> &emsp;② 不建议您恶意利用此程序，如使用此程序运行kali系统进行恶意攻击等，此程序给您带来的任何法律责任，开发者概不负责。      
> &emsp;③ 开发者并未在此程序中写入恶意代码，此程序所执行的一切命令系您自愿。      

-------     
<p align="center">Do Great Things</p>       
