#!/data/data/com.termux/files/usr/bin/bash
#########用于安装此项目脚本#########
clear
echo -e "\033[41;30m======================================================================\033[0m"
echo -e "\033[41;30m           ╔╔   ╔═║  ╔═╝      ║ ║  ╔═║  ╔═╝  ║ ║  ╔═╝  ╔═║            \033[0m"
echo -e "\033[41;30m           ║║║  ║ ║  ╔═╝  ═╝  ╔═║  ╔═║  ║    ╔╝   ╔═╝  ╔╔╝            \033[0m"
echo -e "\033[41;30m           ╝╝╝  ══╝  ══╝      ╝ ╝  ╝ ╝  ══╝  ╝ ╝  ══╝  ╝ ╝            \033[0m"
echo -e "\033[41;30m======================================================================\033[0m"
echo -e "\033[31m                         TERMUX-CONTAINER       \033[0m"
echo -e "\033[31m                           NO WARRANTY          \033[0m"
echo -e "\033[31m                     PRESS ENTER TO CONTINUE    \033[0m"
read
clear
echo -e "\033[41;30m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\033[0m"
echo -e "\033[41;30m             ╝  ╔═   ╔═╝  ═╔╝  ╔═║  ║    ║    ╝  ╔═   ╔═╝             \033[0m"
echo -e "\033[41;30m             ║  ║ ║  ══║   ║   ╔═║  ║    ║    ║  ║ ║  ║ ║             \033[0m"
echo -e "\033[41;30m             ╝  ╝ ╝  ══╝   ╝   ╝ ╝  ══╝  ══╝  ╝  ╝ ╝  ══╝             \033[0m"
echo -e "\033[41;30m<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\033[0m"
echo -e ""
pkg install git wget tsu curl e2fsprogs neofetch
mkdir -p /data/data/com.termux/files/usr/share/termux-container
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share/termux-container
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
echo -e "\033[31mPLEASE RUN container configure\033[0m"
