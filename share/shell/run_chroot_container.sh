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

#XXX
function init_chroot_container() {
  mount -o remount,suid /data
  mount --rbind ${CONTAINER_DIR} ${CONTAINER_DIR}
  mount -o ro,bind /sdcard ${CONTAINER_DIR}/sdcard/
  if [[ ! -e /dev/fd ]]; then
    ln -s /proc/self/fd /dev/ >>/dev/null 2>&1
  fi
  if [[ ! -e /dev/stdin ]]; then
    ln -s /proc/self/fd/0 /dev/stdin >>/dev/null 2>&1
  fi
  if [[ ! -e /dev/stdout ]]; then
    ln -s /proc/self/fd/1 /dev/stdout >>/dev/null 2>&1
  fi
  if [[ ! -e /dev/stderr ]]; then
    ln -s /proc/self/fd/2 /dev/stderr >>/dev/null 2>&1
  fi
  if [[ ! -e /dev/tty0 ]]; then
    ln -s /dev/null /dev/tty0 >>/dev/null 2>&1
  fi
  if [[ ! -e "/dev/net/tun" ]]; then
    [[ -d /dev/net ]] || mkdir -p /dev/net >>/dev/null 2>&1
    mknod /dev/net/tun c 10 200 >>/dev/null 2>&1
  fi
  if [[ ! -e /dev/shm ]]; then
    mkdir -p /dev/shm >>/dev/null 2>&1
    mount -o rw,nosuid,nodev,mode=1777 -t tmpfs tmpfs /dev/shm >>/dev/null 2>&1
  fi
  if ! mountpoint -q ${CONTAINER_DIR}/proc; then
    mount --bind /proc ${CONTAINER_DIR}/proc >>/dev/null 2>&1
  fi
  if ! mountpoint -q ${CONTAINER_DIR}/sys; then
    mount --bind /sys ${CONTAINER_DIR}/sys >>/dev/null 2>&1
  fi
  if ! mountpoint -q ${CONTAINER_DIR}/dev; then
    mount --bind /dev ${CONTAINER_DIR}/dev >>/dev/null 2>&1
  fi
  if ! mountpoint -q ${CONTAINER_DIR}/dev/shm; then
    mount -o bind /dev/shm ${CONTAINER_DIR}/dev/shm >>/dev/null 2>&1
  fi
  if ! mountpoint -q ${CONTAINER_DIR}/dev/pts; then
    mount -o bind /dev/pts ${CONTAINER_DIR}/dev/pts >>/dev/null 2>&1
  fi
}
function run_unshare_container() {
  return
}
function run_capsh_container() {
  #unshare -u -p -m -i capsh --chroot=~/x --shell=/bin/su --
  return
}
function run_rootful_container() {
  return
}
function run_ruri_container() {
  if [[ ! -e $PREFIX/bin/ruri ]]; then
    echo -e "\033[31mError: Can not find ruri installed !${COLOR}"
    return 1
  fi
  CONTAINER_NAME=$1
  if [[ ! -e $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf ]]; then
    echo -e "\033[31mError: Container does not exist !${COLOR}"
    return 1
  fi
  source $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
  if [[ ${BE_SILENT} != 'true' ]]; then
    kernelVersion="$(uname -r)"
    kernelMajor="${kernelVersion%%.*}"
    kernelMinor="${kernelVersion#$kernelMajor.}"
    kernelMinor="${kernelMinor%%.*}"
    kernelPatch="${kernelVersion#*$kernelMinor.}"
    kernelPatch="${kernelPatch%%-*}"
    SELINUX=$(getenforce)
    HOSTNAME=$(hostname)
    ANDROID=$(getprop ro.build.version.release)
    TIME=$(date | awk '{print $4}')
    clear
    printf "${COLOR}"
    echo -e ""
    echo -e "//"
    echo -e ""
    LINE=$(($(stty size | awk '{print $2}')))
    LINE=$(($LINE - 16))
    echo -e "\e[30;1;48;2;254;228;208;38;2;0;0;0mTERMUX-CONTAINER$(yes " " | sed ${LINE}'q' | tr -d '\n')\033[0m"
    echo -e "${COLOR}"
    echo -e "//"
    echo -e ""
    echo -e "    _________      [] CONTAINER: ${CONTAINER_NAME}"
    echo -e "   /        /\\     [] ARCH: $(uname -m)"
    echo -e "  /        /  \\    [] SELINUX: ${SELINUX}"
    echo -e " /        /    \\   [] KERNEL VERSION: $kernelMajor.$kernelMinor.$kernelPatch"
    echo -e "/________/      \\  [] TIME: ${TIME}"
    echo -e "\\        \\      /  [] HOSTNAME: ${HOSTNAME}"
    echo -e " \\        \\    /   [] ANDROID VERSION: ${ANDROID}"
    echo -e "  \\        \\  /    [] CONTAINER DIR: $(echo ${CONTAINER_DIR} | sed 's#/data/data/com.termux/files/home#$HOME#' | sed 's#/data/data/com.termux/files/usr#$PREFIX#')"
    echo -e "   \\________\\/     [] PRIVAGE LEVEL: ${PRIVAGE_LEVEL}"
    echo -e ""
    echo -e "〉TERMUX-CONTAINER"
    LINE=$(($(stty size | awk '{print $2}')))
    echo -e "$(yes "─" | sed ${LINE}'q' | tr -d '\n')"
    echo -e "//////"
    echo -e ""
  fi
  if [[ ! -e ${CONTAINER_DIR} ]]; then
    echo -e "\033[31mError: Container directory does not exist !${COLOR}"
    return 1
  fi
  [[ -e ${CONTAINER_DIR}/sdcard ]] || mkdir -p ${CONTAINER_DIR}/sdcard
  if [[ ${MOUNT_SDCARD} == "true" ]]; then
    mount --bind -o ro /sdcard ${CONTAINER_DIR}/sdcard
  fi
  # Mount termux's tmpdir.
  mount --bind ${PREFIX}/tmp ${CONTAINER_DIR}/tmp
  # Fix nosuid error of sudo.
  mount -o remount,suid /data >>/dev/null 2>&1
  CONTAINER_PARAMETER="-w"
  if [[ ${ENABLE_UNSHARE} == "true" ]]; then
    # Run rurid if it's not running.
    if ! ruri -w -t; then
      ruri -D
    fi
    CONTAINER_PARAMETER+=" -u"
  fi
  if [[ ${PRIVAGE_LEVEL} == "0" ]]; then
    CONTAINER_PARAMETER+=" -d"
  elif [[ ${PRIVAGE_LEVEL} == "2" ]]; then
    CONTAINER_PARAMETER+=" -p"
  fi
  printf "\033[0m"
  unset LD_PRELOAD
  # Use ruri instead of chroot/unshare command.
  ruri ${CONTAINER_PARAMETER} ${CONTAINER_DIR}
}
