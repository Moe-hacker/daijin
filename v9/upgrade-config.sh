#!/data/data/com.termux/files/usr/bin/bash
echo -e "\033[1;38;2;254;228;208mUpgrade script for termux-container v8 to v9."
echo -e "This script will automatically detecte the old config file and try to convert them to the new version."
read -p "Press Enter to continue." x
source $PREFIX/etc/container/global.conf||exit
for i in $(ls $PREFIX/etc/container/container-*.conf)
do
  source $i
  if [[ $RUN_MODE == "chroot-unshare" ]];then
    [[ -e $PREFIX/etc/container/chroot ]]||mkdir -p $PREFIX/etc/container/chroot
    if [[ ! -e $PREFIX/etc/container/chroot/container-${NAME}.conf ]]&&[[ ! -e $PREFIX/etc/container/proot/container-${NAME}.conf ]];then
      echo "CONTAINER_NAME=${NAME}" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "CONTAINER_DIR=${CONTAINER_DIR}" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "MOUNT_SDCARD=${MOUNT_SDCARD}" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "PRIVAGE_LEVEL=2" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "ENABLE_UNSHARE=true" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
    else
      echo -e "Cntainer name ${NAME} already in use,so you need to rename it now."
      while :
      do
        read -p "Name: " NAME
        [[ ! -e $PREFIX/etc/container/chroot/container-${NAME}.conf ]]&&[[ ! -e $PREFIX/etc/container/proot/container-${NAME}.conf ]]&&break
      done
      echo "CONTAINER_NAME=${NAME}" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "CONTAINER_DIR=${CONTAINER_DIR}" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "MOUNT_SDCARD=${MOUNT_SDCARD}" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "PRIVAGE_LEVEL=2" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
      echo "ENABLE_UNSHARE=true" >> $PREFIX/etc/container/chroot/container-${NAME}.conf
    fi
  else
    [[ -e $PREFIX/etc/container/proot ]]||mkdir -p $PREFIX/etc/container/proot
    if [[ ! -e $PREFIX/etc/container/proot/container-${NAME}.conf ]]&&[[ ! -e $PREFIX/etc/container/chroot/container-${NAME}.conf ]];then
      echo "CONTAINER_NAME=${NAME}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
      echo "CONTAINER_DIR=${CONTAINER_DIR}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
      echo "MOUNT_SDCARD=${MOUNT_SDCARD}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
      echo "CROSS_ARCH=${CROSS_ARCH}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
    else
      echo -e "Cntainer name ${NAME} already in use,so you need to rename it now."
      while :
      do
        read -p "Name: " NAME
        [[ ! -e $PREFIX/etc/container/proot/container-${NAME}.conf ]]&&[[ ! -e $PREFIX/etc/container/chroot/container-${NAME}.conf ]]&&break
      done
      echo "CONTAINER_NAME=${NAME}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
      echo "CONTAINER_DIR=${CONTAINER_DIR}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
      echo "MOUNT_SDCARD=${MOUNT_SDCARD}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
      echo "CROSS_ARCH=${CROSS_ARCH}" >> $PREFIX/etc/container/proot/container-${NAME}.conf
    fi
  fi
done
