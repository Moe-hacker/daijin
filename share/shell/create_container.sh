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

# Unpack the rootfs and fix bugs on Android.
function create_chroot_container() {
  ROOTFS=$1
  CONTAINER_DIR=$2
  NEW_USER=$3
  PASSWORD=$4
  printf "${COLOR}"
  if ! mkdir -p ${CONTAINER_DIR}; then
    echo -e "\033[31mError: Failed to create container directory !${COLOR}"
    return 1
  fi
  pv $PREFIX/var/container/$ROOTFS | tar -xJf - -C ${CONTAINER_DIR}
  # Fix permission of /bin/su
  chown root:root ${CONTAINER_DIR}/bin/su
  chmod 777 ${CONTAINER_DIR}/bin/su
  # Create mountpoints.
  [[ -e ${CONTAINER_DIR}/dev ]] || mkdir ${CONTAINER_DIR}/dev
  [[ -e ${CONTAINER_DIR}/proc ]] || mkdir ${CONTAINER_DIR}/proc
  [[ -e ${CONTAINER_DIR}/sys ]] || mkdir ${CONTAINER_DIR}/sys
  [[ -e ${CONTAINER_DIR}/sdcard ]] || mkdir ${CONTAINER_DIR}/sdcard
  # Fix dns problem.
  rm -f ${CONTAINER_DIR}/etc/resolv.conf >>/dev/null 2>&1
  echo nameserver 8.8.8.8 >>${CONTAINER_DIR}/etc/resolv.conf
  echo nameserver 114.114.114.114 >>${CONTAINER_DIR}/etc/resolv.conf
  # Fix network problem.
  cp $PREFIX/share/termux-container/group_add.sh ${CONTAINER_DIR}/tmp
  chmod 777 ${CONTAINER_DIR}/tmp/group_add.sh
  if [[ ${NEW_USER} != "" && ${PASSWORD} != "" ]]; then
    sed -i "s/NEW_USER=\"\"/NEW_USER=${NEW_USER}/" ${CONTAINER_DIR}/tmp/group_add.sh
    sed -i "s/PASSWORD=\"\"/PASSWORD=${PASSWORD}/" ${CONTAINER_DIR}/tmp/group_add.sh
  fi
  mount -t proc proc ${CONTAINER_DIR}/proc/
  mount --rbind /dev ${CONTAINER_DIR}/dev/
  mount --rbind /sys ${CONTAINER_DIR}/sys/
  unset LD_PRELOAD
  $PREFIX/bin/chroot ${CONTAINER_DIR} /tmp/group_add.sh >>/dev/null 2>&1
  umount -lvf ${CONTAINER_DIR}/dev >>/dev/null 2>&1
  umount -lvf ${CONTAINER_DIR}/sys >>/dev/null 2>&1
  umount -lvf ${CONTAINER_DIR}/proc >>/dev/null 2>&1
  umount -lvf ${CONTAINER_DIR} >>/dev/null 2>&1
  printf "${CAT1}\n"
  echo -e "Creation done.\n"
}
# Just like above.
function create_proot_container() {
  ROOTFS=$1
  CONTAINER_DIR=$2
  CROSS_ARCH=$3
  NEW_USER=$4
  PASSWORD=$5
  printf "${COLOR}"
  if ! mkdir -p ${CONTAINER_DIR}; then
    echo -e "\033[31mFailed to create container directory !${COLOR}"
    return 1
  fi
  pv $PREFIX/var/container/$ROOTFS | proot -0 -l tar -xJf - -C ${CONTAINER_DIR}
  [[ -e ${CONTAINER_DIR}/dev ]] || mkdir ${CONTAINER_DIR}/dev
  [[ -e ${CONTAINER_DIR}/proc ]] || mkdir ${CONTAINER_DIR}/proc
  [[ -e ${CONTAINER_DIR}/sys ]] || mkdir ${CONTAINER_DIR}/sys
  [[ -e ${CONTAINER_DIR}/sdcard ]] || mkdir ${CONTAINER_DIR}/sdcard
  rm -f ${CONTAINER_DIR}/etc/resolv.conf >>/dev/null 2>&1
  echo nameserver 8.8.8.8 >>${CONTAINER_DIR}/etc/resolv.conf
  echo nameserver 114.114.114.114 >>${CONTAINER_DIR}/etc/resolv.conf
  cp $PREFIX/share/termux-container/group_add.sh ${CONTAINER_DIR}/tmp/
  chmod 777 ${CONTAINER_DIR}/tmp/group_add.sh
  if [[ ${NEW_USER} != "" && ${PASSWORD} != "" ]]; then
    sed -i "s/NEW_USER=\"\"/NEW_USER=${NEW_USER}/" ${CONTAINER_DIR}/tmp/group_add.sh
    sed -i "s/PASSWORD=\"\"/PASSWORD=${PASSWORD}/" ${CONTAINER_DIR}/tmp/group_add.sh
  fi
  unset LD_PRELOAD
  COMMAND="proot --link2symlink --sysvipc -0 -r ${CONTAINER_DIR} -b /dev -b /sys -b /proc -w /root"
  if [[ ${CROSS_ARCH} != "null" ]]; then
    COMMAND+=" -q qemu-${CROSS_ARCH}"
  fi
  ${COMMAND} /tmp/group_add.sh >>/dev/null 2>&1
  printf "${CAT1}\n"
  echo -e "Creation done.\n"
}
