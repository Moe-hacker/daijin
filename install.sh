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
echo -e "\033[${i5}G\033[38;5;123m    BY MOE-HACKER 2021"|pv -qL 20
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
pkg install git wget tsu curl e2fsprogs neofetch nano
clear
echo -e "\033[${i5}G\033[38;5;123mCLONING REPOSITORY"|pv -qL 20
mkdir -p /data/data/com.termux/files/usr/share/termux-container
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share/termux-container
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
clear
echo -e "\033[${i5}G\033[38;5;123mCONTAINER_SETTINGS"|pv -qL 20
read -p "DISABLE SELinux?[y/n]: " SELINUX
read -p "ENTER YOUR HOSTNAME: " HOSTNAME
read -p "ENABLE OUTPUT?[y/n]: " OUTPUT
echo -e "CHOOSE YOUR CUSOR: "
read -p '[1]: $|   [2]: $▂   [3]: $█ ' CUSOR
case ${CUSOR} in
  1) CUSOR=bar;;
  2) CUSOR=underline;;
  3) CUSOR=block;;
esac
printf '\e[2 q\033[0m'
echo SELINUX=${SELINUX} >> /data/data/com.termux/files/usr/etc/container.conf
echo OUTPUT=${OUTPUT} >> /data/data/com.termux/files/usr/etc/container.conf
echo HOSTNAME=${HOSTNAME} >> /data/data/com.termux/files/usr/etc/container.conf
echo CUSOR=${CUSOR} >> /data/data/com.termux/files/usr/etc/container.conf
#   │  │   ╔══╝╔══║╔══╝
# ── ── ── ║   ║  ║║
#   │  │   ╔══╝║  ║╔══╝
# ── ── ── ║   ║  ║║
#   │  │   ═══╝═══╝╝
