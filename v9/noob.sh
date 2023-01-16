#####proot -0
#######################
export WIDTH=$(($(stty size|awk '{print $2}')-8))
INSTALL(){
  if whiptail --title "[] RUN MODE" --yes-button "chroot" --no-button "proot"  --yesno "if your phone is rooted,it is recommand to run container with chroot mode\nIf not ,please choose proot\n\nPlease choose your run mode:" 12 $WIDTH;then
    TYPE=chroot
  else
    TYPE=proot
  fi
  LIST="1 alpine 2 archlinux 3 centos 4 debian 5 fedora 6 kali 7 manjaro 8 opensuse 9 parrot 10 ubuntu"
  LIST2="alpine archlinux centos debian fedora kali manjaro opensuse parrot ubuntu"
  NUMBER=$(whiptail --title "[] OS" --menu "Choose the OS to install:" 15 $WIDTH 6 $LIST 3>&1 1>&2 2>&3)
  OS=$(echo $LIST2|awk "{print \$$NUMBER}")
  unset LIST LIST2 NUMBER
  if [[ ${OS} != "parrot" ]]&&[[ ${OS} != "manjaro" ]];then
    NUMBER=0
    for VERSION in $(curl -sL http://images.linuxcontainers.org/images/$OS|grep "DIR"|sed -E 's@<a (href)@\n\1@g'| awk -F 'href=' '{print $2}' | cut -d '"' -f 2 |cut -d "/" -f 1);do NUMBER=$(($NUMBER+1));LIST+="$NUMBER $VERSION ";LIST2+="$VERSION ";done
    unset VERSION NUMBER
    NUMBER=$(whiptail --title "[] VERSION" --menu "Choose the version to install:" 15 $WIDTH 6 $LIST 3>&1 1>&2 2>&3)
    VERSION=$(echo $LIST2|awk "{print \$$NUMBER}")
  fi
  echo $OS $VERSION
}
REMOVE(){
  NUMBER=0
  if [[ -e $PREFIX/etc/container/proot ]];then
    for i in $(ls $PREFIX/etc/container/proot);do
      NAME=${i#*-}
      NAME=${NAME%%.*}
      NUMBER=$(($NUMBER+1))
      LIST+="$NUMBER $NAME(proot) "
      LIST2+="$NAME "
    done
  fi
  if [[ -e $PREFIX/etc/container/chroot ]];then
    for i in $(ls $PREFIX/etc/container/chroot);do
      NAME=${i#*-}
      NAME=${NAME%%.*}
      LIST+="$NUMBER $NAME(chroot) "
      LIST2+="$NAME "
    done
  fi
  unset i NUMBER
  if [[ $LIST == "" ]];then
    whiptail --title "[] ERROR" --msgbox "No container installed!" 7 $WIDTH
    return 1
  fi
  NUMBER=$(whiptail --title "[] CONTAINER" --menu "Choose the container to remove:" 15 $WIDTH 6 $LIST 3>&1 1>&2 2>&3)
  CONTAINER=$(echo $LIST2|awk "{print \$$NUMBER}")
}
RUN(){
  NUMBER=0
  if [[ -e $PREFIX/etc/container/proot ]];then
    for i in $(ls $PREFIX/etc/container/proot);do
      NAME=${i#*-}
      NAME=${NAME%%.*}
      NUMBER=$(($NUMBER+1))
      LIST+="$NUMBER $NAME(proot) "
      LIST2+="$NAME "
    done
  fi
  if [[ -e $PREFIX/etc/container/chroot ]];then
    for i in $(ls $PREFIX/etc/container/chroot);do
      NAME=${i#*-}
      NAME=${NAME%%.*}
      LIST+="$NUMBER $NAME(chroot) "
      LIST2+="$NAME "
    done
  fi
  unset i NUMBER
  if [[ $LIST == "" ]];then
    whiptail --title "[] ERROR" --msgbox "No container installed!" 7 $WIDTH
    return 1
  fi
  NUMBER=$(whiptail --title "[] CONTAINER" --menu "Choose the container to run:" 15 $WIDTH 6 $LIST 3>&1 1>&2 2>&3)
  CONTAINER=$(echo $LIST2|awk "{print \$$NUMBER}")
}
OPTION=$(whiptail --title "[] TERMUX-CONTAINER" --menu "Choose an operation:" 15 $WIDTH 6 1 install 2 remove 3 run 3>&1 1>&2 2>&3)
case $OPTION in
  1) INSTALL;;
  2) REMOVE;;
  3) RUN;;
esac