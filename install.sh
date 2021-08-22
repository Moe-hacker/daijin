#!/data/data/com.termux/files/usr/bin/bash
#########用于安装此项目脚本#########
clear
echo -e "\033[31mTERMUX-CONTAINER BY MOE-HACKER\033[0m"
echo -e "\033[31m         NO WARRANTY          \033[0m"
echo -e "\033[31m   PRESS ENTER TO CONTINUE    \033[0m"
read
echo -e "\033[31mTERMUX-CONTAINER\033[0m"
echo -e "\033[31mBY MOE-HACKER\033[0m"
echo -e "\033[31mGPL-V3 LICENSE\033[0m"
echo -e "\033[31m//\033[0m"
echo -e ""
echo -e "\033[41;37mINSTALLING...                                    \033[0m"
echo -e ""
echo -e "\033[31m//\033[0m"
echo -e ""
sleep 1s
echo -e "\033[31mNO WARRANTY\033[0m"
echo -e "\033[31mKERNEL $(uname --kernel-release)\033[0m"
echo -e "\033[31mTIME $(date|awk '{print $4}')\033[0m"
echo -e "\033[31mANDROID $(neofetch |grep Android|awk '{print $3}')\033[0m"
sleep 1s
echo -e ""
echo -e "\033[31m                o            o\033[0m"
echo -e "\033[31m                 o          o\033[0m"
echo -e "\033[31m                 +hydNNNNdyh+\033[0m"
echo -e "\033[31m               +mMMMMMMMMMMMMm+\033[0m"
echo -e "\033[31m              dMM::NMMMMMMN::MMd \033[0m"
echo -e "\033[31m             hMMMMMMMMMMMMMMMMMMh\033[0m"
echo -e "\033[31m        ╔═║  ╔═   ╔═   ╔═║  ╔═║  ║  ╔═"
echo -e "\033[31m        ╔═║  ║ ║  ║ ║  ╔╔╝  ║ ║  ║  ║ ║"
echo -e "\033[31m        ╝ ╝  ╝ ╝  ══   ╝ ╝  ══╝  ╝  ══"
echo -e ""
sleep 1s
echo -e "\033[31m1001011 1100101 1100101 1110000 1100111 0100000\033[0m"
echo -e "\033[31m1101101 1101111 1100101 1011000 1101011 1000011\033[0m"
echo -e "\033[31m1100101 1100101 1110000 1000000 1100011 1101110\033[0m"
echo -e "\033[31m1101111 1101111 1101100 1011000 1101011 1101011\033[0m"
echo -e "\033[31m1100101 1100101 1110000 1000000 1101000 1100110\033[0m"
echo -e "\033[31m1100001 1100011 1101011 1101000 1101110 1000000\033[0m"
echo -e "\033[31m1100111 1011001 1101011 1100101 1100101 1100110\033[0m"
echo -e "\033[31m1110000 1000001 1100110 1101001 1111001 1000010\033[0m"
echo -e "\033[31m1101001 1101110 1100111 1011100 0001010 1101011\033[0m"
echo -e "\033[31m1011011 1011011 1011010 1011010 1010100 1101110\033[0m"
echo -e "\033[31m1100001 1101100 1101011 1000000 1101001 1000000\033[0m"
echo -e "\033[31m1110011 1000000 1100011 1101000 1100101 1011001\033[0m"
echo -e "\033[31m1100001 1110000 1011000 1110011 1101000 1101011\033[0m"
echo -e "\033[31m1101111 1110111 1000000 1101101 1100101 1100101\033[0m"
echo -e "\033[31m1000001 1110100 1101000 1100101 0100000 1100110\033[0m"
echo -e "\033[31m1100011 1101111 1100100 1100101 0101110 1011000\033[0m"
echo -e "\033[31m1101001 1101110 1100111 1011100 0001010 1000000\033[0m"
echo -e "\033[31m1100001 1100011 1101011 1101000 1101110 1011000\033[0m"
echo -e ""
sleep 1s
echo -e "\033[31m//\033[0m"
echo -e "\033[31mNEVER SETTLE\033[0m"
echo -e "\033[31m//"
sleep 1s
pkg install git wget tsu curl e2fsprogs neofetch
mkdir -p /data/data/com.termux/files/usr/share/termux-container
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share/termux-container
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
echo -e "\033[31mPLEASE RUN container configure\033[0m"
