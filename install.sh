#!/data/data/com.termux/files/usr/bin/bash
#########用于安装此项目脚本########
clear
printf '\e[6 q'
printf '\033[?25l'
i1=$(($(stty size|awk '{print $2}')))
let i1=$i1
i4=$(($i1/2-22))
echo -e "\033[${i4}G              \033[32m┌───────────┐"
echo -e "\033[${i4}G              │ ┌───────┐ │"
echo -e "\033[${i4}G              │ │  \033[33m┌───────────┐"
echo -e "\033[${i4}G              \033[32m│ │  \033[33m│ ┌───────┐ │"
echo -e "\033[${i4}G              \033[32m│ │  \033[33m│ │  \033[32m│ │  \033[33m│ │"
echo -e "\033[${i4}G              \033[32m│ └──\033[33m│ │\033[32m──┘ │  \033[33m│ │"
echo -e "\033[${i4}G              \033[32m└────\033[33m│ │\033[32m────┘  \033[33m│ │"
echo -e "\033[${i4}G                   \033[33m│ └───────┘ │"
echo -e "\033[${i4}G                   \033[33m└───────────┘"
echo -e "\033[${i4}G\033[34m═╔╝╔═╝╔═║╔╔ ║ ║║ ║  ╔═╝╔═║╔═ ═╔╝╔═║╝╔═ ╔═╝╔═║"
echo -e "\033[${i4}G ║ ╔═╝╔╔╝║║║║ ║ ╝ ═╝║  ║ ║║ ║ ║ ╔═║║║ ║╔═╝╔╔╝"
echo -e "\033[${i4}G ╝ ══╝╝ ╝╝╝╝══╝╝ ╝  ══╝══╝╝ ╝ ╝ ╝ ╝╝╝ ╝══╝╝ ╝"
i2=0
while (( $i2<=$i1 ));do
    i2=$(($i2+1))
    echo -e "\033[38;5;123m\033[13H\033[${i2}G="
    sleep 0.01s
done
i5=$(($i4+9))
echo -e "\033[${i5}G\033[38;5;123m      BY MOE-HACKER"|pv -qL 20
echo -e "\033[${i5}G\033[38;5;123m    KEEP MOE KEEP COOL"|pv -qL 20
echo -e "\033[${i5}G\033[38;5;123m       NO WARRANTY"|pv -qL 20
echo -e "\033[${i5}G\033[38;5;123m        NOT EVIL"|pv -qL 20
echo -e "\033[${i5}G\033[38;5;123mPRESS ENTER TO CONTINUE"|pv -qL 20
i2=0
printf '\033[?25h'
read
clear
i2=0
while (( $i2<=$i1 ));do
    i2=$(($i2+1))
    echo -e "\033[38;5;123m\033[1H\033[${i2}G<"
    sleep 0.01s
done
echo -e "\033[38;5;123m\033[${i4}G ╝  ╔═   ╔═╝  ═╔╝  ╔═║  ║    ║    ╝  ╔═   ╔═╝\033[0m"
echo -e "\033[38;5;123m\033[${i4}G ║  ║ ║  ══║   ║   ╔═║  ║    ║    ║  ║ ║  ║ ║\033[0m"
echo -e "\033[38;5;123m\033[${i4}G ╝  ╝ ╝  ══╝   ╝   ╝ ╝  ══╝  ══╝  ╝  ╝ ╝  ══╝\033[0m"
i2=0
while (( $i2<=$i1 ));do
    i2=$(($i2+1))
    echo -e "\033[38;5;123m\033[5H\033[${i2}G>"
    sleep 0.01s
done
sleep 2s
clear
echo -e "\033[${i5}G\033[38;5;123mINSTALLING PACKAGES"|pv -qL 20
pkg install git wget tsu curl e2fsprogs neofetch
clear
echo -e "\033[${i5}G\033[38;5;123mCLONING REPOSITORY"|pv -qL 20
mkdir -p /data/data/com.termux/files/usr/share/termux-container
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share/termux-container
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
clear
y3=20
i4=$(($i4-5))
echo -e "\033[${i5}G\033[38;5;123mPLEASE RUN container -c"|pv -qL 20
