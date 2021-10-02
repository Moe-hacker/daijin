#!/data/data/com.termux/files/usr/bin/bash
#########用于安装此项目脚本#########
clear
for a1 in {1..70};do
  echo -e "\033[38;5;123m\033[1H\033[${a1}G=\033[0m"
  sleep 0.02s
done
echo -e "\033[38;5;123m           ╔╔   ╔═║  ╔═╝      ║ ║  ╔═║  ╔═╝  ║ ║  ╔═╝  ╔═║            \033[0m"
echo -e "\033[38;5;123m           ║║║  ║ ║  ╔═╝  ═╝  ╔═║  ╔═║  ║    ╔╝   ╔═╝  ╔╔╝            \033[0m"
echo -e "\033[38;5;123m           ╝╝╝  ══╝  ══╝      ╝ ╝  ╝ ╝  ══╝  ╝ ╝  ══╝  ╝ ╝            \033[0m"
for a2 in {1..70};do
  echo -e "\033[38;5;123m\033[5H\033[${a2}G=\033[0m"
  sleep 0.02s
done
x1=26
for i1 in {T,E,R,M,U,X,-,C,O,N,T,A,I,N,E,R};do
  x1=$(($x1+1))
  echo -e "\033[38;5;123m\033[6H\033[${x1}G$i1"
  sleep 0.1s
done
x2=27
for i2 in {B,Y,:,"",M,O,E,-,H,A,C,K,E,R};do
  x2=$(($x2+1))
  echo -e "\033[38;5;123m\033[7H\033[${x2}G$i2"
  sleep 0.1s
done
x3=29
for i3 in {N,O,"",W,A,R,R,A,N,T,Y};do
  x3=$(($x3+1))
  echo -e "\033[38;5;123m\033[8H\033[${x3}G$i3"
  sleep 0.1s
done
x4=23
for i4 in {P,R,E,S,S,"",E,N,T,E,R,"",T,O,"",C,O,N,T,I,N,U,E};do
  x4=$(($x4+1))
  echo -e "\033[38;5;123m\033[9H\033[${x4}G$i4"
  sleep 0.1s
done
read
clear
for a2 in {1..70};do
  echo -e "\033[38;5;123m\033[1H\033[${a2}G<\033[0m"
  sleep 0.02s
done
echo -e "\033[38;5;123m             ╝  ╔═   ╔═╝  ═╔╝  ╔═║  ║    ║    ╝  ╔═   ╔═╝             \033[0m"
echo -e "\033[38;5;123m             ║  ║ ║  ══║   ║   ╔═║  ║    ║    ║  ║ ║  ║ ║             \033[0m"
echo -e "\033[38;5;123m             ╝  ╝ ╝  ══╝   ╝   ╝ ╝  ══╝  ══╝  ╝  ╝ ╝  ══╝             \033[0m"
for a3 in {1..70};do
  echo -e "\033[38;5;123m\033[5H\033[${a3}G>\033[0m"
  sleep 0.02s
done
sleep 2s
clear
y1=25
for i5 in {I,N,S,T,A,L,L,I,N,G,"",P,A,C,K,A,G,E,S};do
  y1=$(($y1+1))
  echo -e "\033[38;5;123m\033[1H\033[${y1}G$i5"
  sleep 0.1s
done
pkg install git wget tsu curl e2fsprogs neofetch
clear
y2=25
for i6 in {C,L,O,N,I,I,N,G,"",R,E,P,O,S,I,T,O,R,Y};do
  y2=$(($y2+1))
  echo -e "\033[38;5;123m\033[1H\033[${y2}G$i6"
  sleep 0.1s
done
mkdir -p /data/data/com.termux/files/usr/share/termux-container
git clone https://github.com/Moe-hacker/termux-container /data/data/com.termux/files/usr/share/termux-container
cd /data/data/com.termux/files/usr/share/termux-container
cp container /data/data/com.termux/files/usr/bin/
clear
y3=20
for i7 in {P,L,E,A,S,E,"",R,U,N,"",c,o,n,t,a,i,n,e,r,"",c,o,n,f,i,g,u,r,e};do
  y3=$(($y3+1))
  echo -e "\033[38;5;123m\033[1H\033[${y3}G$i7"
  sleep 0.1s
done
