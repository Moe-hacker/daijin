#########用于安装此项目脚本#########
#!/data/data/com.termux/files/usr/bin/bash
pkg install git wget tsu curl e2fsprogs
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
container configure
