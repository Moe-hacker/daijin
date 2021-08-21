#!/data/data/com.termux/files/usr/bin/bash
#########用于安装此项目脚本#########
echo -e "\033[34m***********************************************\033[0m"
echo -e "\033[34m*********\033[32mtermux-containe by Moe-hacker\033[34m*********\033[0m"
echo -e "\033[34m*********\033[31m        NO WARRANTY          \033[34m*********\033[0m"
echo -e "\033[34m*********\033[32m   Press Enter to continue   \033[34m*********\033[0m"
echo -e "\033[34m***********************************************\033[0m"
read
pkg install git wget tsu curl e2fsprogs
mkdir -p /data/data/com.termux/files/usr/share/termux-container
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share/termux-container
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
echo -e "\033[34mPlease run \033[33mcontainer configure\033[0m"
