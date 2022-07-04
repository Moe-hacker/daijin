# Copyright 2023 moe-hacker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function remove_container() {
  CONTAINER_NAME=$1
  if [[ -e $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf ]]; then
    source $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
    echo -e "${COLOR}======================================="
    echo -e "Name                : ${CONTAINER_NAME}"
    echo -e "OS                  : ${OS}"
    echo -e "TYPE                : proot"
    echo -e "Container directory : ${CONTAINER_DIR}"
    echo
    read -p "Press Enter to remove this container or CTRL-C to exit."
    chmod -Rv 777 ${CONTAINER_DIR}
    rm -rfv ${CONTAINER_DIR}
    rm -v $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
  elif [[ -e $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf ]]; then
    source $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
    if [[ $(whoami) != "root" ]]; then
      sudo container -e REMOVE_CONTAINER $1
      return
    fi
    source $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
    echo -e "======================================="
    echo -e "Name                : ${CONTAINER_NAME}"
    echo -e "OS                  : ${OS}"
    echo -e "TYPE                : chroot"
    echo -e "Container directory : ${CONTAINER_DIR}"
    echo
    read -p "Press Enter to remove this container or CTRL-C to exit."
    for i in {0..10}; do
      umount -lvf ${CONTAINER_DIR}/dev >>/dev/null 2>&1
      umount -lvf ${CONTAINER_DIR}/sys >>/dev/null 2>&1
      umount -lvf ${CONTAINER_DIR}/proc >>/dev/null 2>&1
      umount ${CONTAINER_DIR}/sdcard >>/dev/null 2>&1
      umount ${CONTAINER_DIR}/tmp >>/dev/null 2>&1
      umount -lvf ${CONTAINER_DIR} >>/dev/null 2>&1
    done
    if mountpoint -q ${CONTAINER_DIR}/sdcard; then
      echo -e "\033[31mError: can not umount container at this time !${COLOR}"
      return 1
    fi
    if mountpoint -q ${CONTAINER_DIR}/tmp; then
      echo -e "\033[31mError: can not umount container at this time !${COLOR}"
      return 1
    fi
    if mountpoint -q ${CONTAINER_DIR}/dev; then
      echo -e "\033[31mError: can not umount container at this time !${COLOR}"
      return 1
    fi
    if mountpoint -q ${CONTAINER_DIR}/sys; then
      echo -e "\033[31mError: can not umount container at this time !${COLOR}"
      return 1
    fi
    if mountpoint -q ${CONTAINER_DIR}/proc; then
      echo -e "\033[31mError: can not umount container at this time !${COLOR}"
      return 1
    fi
    rm -rvf ${CONTAINER_DIR}
    rm -v $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
  else
    echo -e "\033[31mError: container does not exist !${COLOR}"
    return
  fi
}
function create_new_container() {
  # XXX
  x="
┏━━━━━━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━┳━━━━━━━━
┃ container backend  ┃       ┃      ┃               ┃       ┃         ┃
┠────────────────────┨ proot ┃ ruri ┃ capsh+unshare ┃ capsh ┃ unshare ┃ chroot 
┃ supported feature  ┃       ┃      ┃               ┃       ┃         ┃
┣━━━━━━━━━━━━━━━━━━━━╋━━━━━━━╋━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━╋━━━━━━━━━╋━━━━━━━━
┃     rootless       ┃   ◯   ┃   X  ┃       X       ┃   X   ┃    X    ┃   X
┣━━━━━━━━━━━━━━━━━━━━╋━━━━━━━╋━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━╋━━━━━━━━━╋━━━━━━━━
┃ namespace support  ┃   X   ┃   ◯  ┃       ◯*      ┃   X   ┃    ◯*   ┃   X
┣━━━━━━━━━━━━━━━━━━━━╋━━━━━━━╋━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━╋━━━━━━━━━╋━━━━━━━━
┃ capability control ┃   X   ┃   ◯  ┃       ◯       ┃   ◯   ┃    X    ┃   X

*capsh+unshare/unshare will not keep the same container running in the same namspaces.
  "
  #XXX
  get_cpu_arch
  echo
  echo -e "${COLOR}Enter the name of this container."
  while :; do
    read -p "[] Name > " CONTAINER_NAME
    if [[ $? != 0 ]]; then
      echo
      return 1
    fi
    if [[ ${CONTAINER_NAME} != "" ]]; then
      if [[ ! -e $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf ]] && [[ ! -e $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf ]]; then
        echo
        break
      else
        echo -e "\033[31mError: container name already in use !${COLOR}"
      fi
    fi
  done
  echo -e "If your phone is rooted,it is recommand to run container with chroot mode.If not or you want to run cross-arch container,please choose proot."
  echo -e "Chroot mode will use ruri for unshare feature and capability reduse to make the container more secure,see:\n\033[4mhttps://github.com/Moe-hacker/ruri\033[0m${COLOR}"
  echo -e "Before you use it,you should allow the MIT License of it:\n\033[4mhttps://github.com/Moe-hacker/ruri/blob/main/LICENSE\033[0m${COLOR}"
  echo -e "\nEnter the type of this container."
  while :; do
    read -p "[] Type [chroot/proot] > " CONTAINER_TYPE
    if [[ $? != 0 ]]; then
      echo
      return 1
    fi
    if [[ ${CONTAINER_TYPE} == "chroot" ]] || [[ ${CONTAINER_TYPE} == "proot" ]]; then
      break
    fi
  done
  if [[ ${CONTAINER_TYPE} == "chroot" ]]; then
    echo -e "\nUnshare mode will use namespace features of Linux kernel to provide more security,but some devices may crash after using it.\n"
    while :; do
      read -p "[] Enable unshare [true/false] > " ENABLE_UNSHARE
      if [[ $? != 0 ]]; then
        echo
        return 1
      fi
      if [[ ${ENABLE_UNSHARE} == "true" ]] || [[ ${ENABLE_UNSHARE} == "false" ]]; then
        break
      fi
    done
    echo -e "\nThe privilege level determines the privileges that the container can get. 0 is the lowest and 2 is the highest.Lower privileges can make the container more secure,but operations like mount will not be authorized in the container.It's recommended to set it to 1.\n"
    while :; do
      read -p "[] Privilege level [0-2] > " PRIVAGE_LEVEL
      if [[ $? != 0 ]]; then
        echo
        return 1
      fi
      if [[ ${PRIVAGE_LEVEL} == "0" ]] || [[ ${PRIVAGE_LEVEL} == "1" ]] || [[ ${PRIVAGE_LEVEL} == "2" ]]; then
        break
      fi
    done
  else
    echo -e "\nYou can use qemu to simulate another CPU architecture to run containers,however,the performance is not ideal."
    echo -e "Available CPU architectures are: arm64 armhf amd64 i386 m68k ppc ppc64el riscv32 riscv64"
    echo -e "If you don't want to use qemu,just press Enter here.\n"
    while :; do
      read -p "[] CPU architecture > " CPU_ARCH
      if [[ $? != 0 ]]; then
        echo
        return 1
      fi
      case ${CPU_ARCH} in
      "i386" | "m68k" | "ppc" | "riscv32" | "riscv64")
        export CPU_ARCH=${CROSS_ARCH} && apt install qemu-user-${CROSS_ARCH}
        break
        ;;
      "arm64")
        export CROSS_ARCH=aarch64 && apt install qemu-user-${CROSS_ARCH}
        break
        ;;
      "armhf")
        export CROSS_ARCH=arm && apt install qemu-user-${CROSS_ARCH}
        break
        ;;
      "amd64")
        export CROSS_ARCH=x86_64 && apt install qemu-user-x86-64
        break
        ;;
      "ppc64el")
        export CROSS_ARCH=ppc64 && apt install qemu-user-${CROSS_ARCH}
        break
        ;;
      "") get_cpu_arch && export CROSS_ARCH=null && break ;;
      esac
    done
  fi
  echo -e "\nYou can mount /sdcard to the container to share files in your phone.However,it's not a secure way.It's recommended to use \`container cp\` instead.\n"
  while :; do
    read -p "[] Mount sdcard [true/false] > " MOUNT_SDCARD
    if [[ $? != 0 ]]; then
      echo
      return 1
    fi
    if [[ ${MOUNT_SDCARD} == "true" ]] || [[ ${MOUNT_SDCARD} == "false" ]]; then
      break
    fi
  done
  echo -e "\nYou can create a new common user in the container.If you don't want it,just press Enter here.\n"
  while :; do
    read -p "[] Username > " NEW_USER
    if [[ $? != 0 ]]; then
      echo
      return 1
    fi
    break
  done
  if [[ ${NEW_USER} != "" ]]; then
    while :; do
      read -p "[] Password > " PASSWORD
      if [[ $? != 0 ]]; then
        echo
        return 1
      fi
      if [[ ${PASSWORD} != "" ]]; then
        break
      fi
    done
  fi
  echo -e "\nThe container absolute path is the directory used to store the container,for chroot,you can use /data/container-name,and for proot,you can use /data/data/com.termux/files/home/container-name,but do not use directory in /sdcard,or you might run into problems !\n"
  echo -e "Enter the absolute path of container."
  while :; do
    read -p "[] Container path > " CONTAINER_DIR
    if [[ $? != 0 ]]; then
      echo
      return 1
    fi
    if [[ -e ${CONTAINER_DIR} ]]; then
      echo -e "\033[31mError: container directory already exist !${COLOR}"
      continue
    fi
    for BLACKLIST in {/bin/,/dev/,/odm/,/oem/,/proc/,/product/,/sys/,/system/,/vendor/}; do
      if [[ ${CONTAINER_DIR} = $BLACKLIST* ]]; then
        echo -e "\033[31mError: refuse to use system directory !${COLOR}"
        CONTINUE=true
      fi
    done
    if [[ ${CONTINUE} == "true" ]]; then
      continue
    fi
    if [[ ${CONTAINER_DIR:0:1} != "/" ]]; then
      echo -e "\033[31mError: please use absolute path !${COLOR}"
      continue
    else
      break
    fi
  done
  echo -e "\nChoose the OS and the version to install,you can use \`search\` command here."
  while :; do
    read -p "[] OS > " OS
    if [[ $? != 0 ]]; then
      echo
      return 1
    fi
    if [[ $(echo $OS | awk '{print $1}') == search ]]; then
      search_images $(echo $OS | awk '{print $2}') $CPU_ARCH
      printf "${COLOR}"
      continue
    fi
    if [[ ${OS} != "" ]]; then
      while :; do
        printf "${COLOR}"
        read -p "[] Vesion > " VERSION
        if [[ $? != 0 ]]; then
          echo
          return 1
        fi
        if [[ ${VERSION} != "" ]]; then
          if [[ ! -e $PREFIX/var/container/${OS}-${VERSION}-${CPU_ARCH}.tar.xz ]]; then
            PULL_ROOTFS ${OS} ${VERSION} ${CPU_ARCH} && break
          else
            break
          fi
        fi
      done
      break
    fi
  done
  echo -e "Before creating the container,you need to make sure the config is all right:"
  if [[ ${CONTAINER_TYPE} == "chroot" ]]; then
    echo -e "Type            : chroot"
    echo -e "Enable unshare  : ${ENABLE_UNSHARE}"
    echo -e "Privilege level : ${PRIVAGE_LEVEL}"
  else
    echo -e "Type            : proot"
    echo -e "Cross-arch      : ${CROSS_ARCH}"
  fi
  echo -e "Name            : ${CONTAINER_NAME}"
  echo -e "Container path  : ${CONTAINER_DIR}"
  echo -e "New user        : ${NEW_USER}"
  echo -e "Password        : ${PASSWORD}"
  echo -e "OS              : ${OS}"
  echo -e "Version         : ${VERSION}"
  echo -e "Mount sdcard    : ${MOUNT_SDCARD}"
  read -p "Continue [y/n] " CONTINUE
  if [[ ${CONTINUE} == "n" ]]; then
    return 1
  fi
  if [[ ${CONTAINER_TYPE} == "chroot" ]]; then
    sudo container -e CREATE_CHROOT_CONTAINER ${OS}-${VERSION}-${CPU_ARCH}.tar.xz ${CONTAINER_DIR} ${NEW_USER} ${PASSWORD}
    [[ -e $PREFIX/etc/container/chroot ]] || mkdir -p $PREFIX/etc/container/chroot
    echo -e "#This file was automatically created by termux-container.\n#Do not edit this file if you don't know what you are doing !" >>$PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
    echo -e "OS=${OS}\nCONTAINER_DIR=${CONTAINER_DIR}\nENABLE_UNSHARE=${ENABLE_UNSHARE}\nPRIVAGE_LEVEL=${PRIVAGE_LEVEL}\nCROSS_ARCH=null\nMOUNT_SDCARD=${MOUNT_SDCARD}" >>$PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
  else
    export CROSSARCH=${CROSS_ARCH}
    CREATE_PROOT_CONTAINER ${OS}-${VERSION}-${CPU_ARCH}.tar.xz ${CONTAINER_DIR} ${CROSS_ARCH} ${NEW_USER} ${PASSWORD}
    [[ -e $PREFIX/etc/container/proot ]] || mkdir -p $PREFIX/etc/container/proot
    echo -e "#This file was automatically created by termux-container.\n#Do not edit this file if you don't know what you are doing !" >>$PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
    echo -e "OS=${OS}\nCONTAINER_DIR=${CONTAINER_DIR}\nCROSS_ARCH=${CROSSARCH}\nMOUNT_SDCARD=${MOUNT_SDCARD}" >>$PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
  fi
}
function container_list() {
  echo
  echo -e "${COLOR}Images:"
  echo -e "OS:Version:Arch"
  echo -e "================"
  if [[ -e $PREFIX/var/container ]]; then
    for IMAGE in $(ls $PREFIX/var/container); do
      OS=${IMAGE%%-*}
      VERSION=${IMAGE#$OS-}
      VERSION=${VERSION%-*}
      CPU_ARCH=${IMAGE#*$VERSION-}
      CPU_ARCH=${CPU_ARCH%%.*}
      echo "$OS:$VERSION:$CPU_ARCH"
    done
  fi
  echo
  echo
  echo -e "Containers:"
  echo -e "Type:Name"
  echo -e "================"
  if [[ -e $PREFIX/etc/container/proot ]]; then
    for CONTAINER in $(ls $PREFIX/etc/container/proot); do
      NAME=${CONTAINER#container-}
      NAME=${NAME%%.conf}
      echo "proot:$NAME"
    done
  fi
  if [[ -e $PREFIX/etc/container/chroot ]]; then
    for CONTAINER in $(ls $PREFIX/etc/container/chroot); do
      NAME=${CONTAINER#container-}
      NAME=${NAME%%.conf}
      echo "chroot:$NAME"
    done
  fi
  echo
}
# XXX
function export_container() {
  CONTAINER_NAME=$1
  if [[ -e $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf ]]; then
    export TYPE=proot
    source $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
  elif [[ -e $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf ]]; then
    export TYPE=chroot
    if [[ $(whoami) != "root" ]]; then
      sudo container -e EXPORT_CONTAINER ${CONTAINER_NAME}
      return
    fi
  else
    echo -e "\033[31mError: container does not exist !${COLOR}"
    return
  fi
  FILE=/sdcard/${OS}-${CPU_ARCH}-${CROSS_ARCH}-${CONTAINER_NAME}-$(date +%y%m%d%H%M%S).tar.xz
  if ! cd ${CONTAINER_DIR}; then
    echo -e "\033[31mError: container directory does not exist !${COLOR}"
    return
  fi
  printf "${COLOR}"
  if [[ ${TYPE} == "chroot" ]]; then
    tar -JPpcvf ${FILE} .
  else
    proot -l tar -JPpcvf ${FILE} .
  fi
  echo -e "Export done, file: ${FILE}"
}
function import_rootfs() {
  FILE=$1
  if [[ ! -e ${FILE} ]]; then
    echo -e "\033[31mError: rootfs file does not exist !${COLOR}"
    return 1
  fi
  while :; do
    read -p "[] OS > " OS
    if [[ ${OS} != "" ]]; then
      break
    fi
  done
  while :; do
    read -p "[] Arch > " CPU_ARCH
    case $CPU_ARCH in
    "i386" | "m68k" | "ppc" | "riscv32" | "riscv64" | "arm64" | "armhf" | "ppc64" | "amd64") break ;;
    esac
  done
  while :; do
    read -p "[] Version > " VERSION
    if [[ ${VERSION} != "" ]] && [[ ! -e $PREFIX/var/container/${OS}-${VERSION}-${CPU_ARCH}.tar.xz ]]; then
      break
    else
      echo -e "\033[31mError: OS version already in use !")${COLOR}"
    fi
  done
  cp ${FILE} $PREFIX/var/container/${OS}-${VERSION}-${CPU_ARCH}.tar.xz
}
