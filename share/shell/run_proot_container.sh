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

function run_proot_container() {
  CONTAINER_NAME=$1
  if [[ ! -e $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf ]]; then
    echo -e "\033[31mError: Container does not exist !${COLOR}"
    return 1
  fi
  source $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
  if [[ ${BE_SILENT} != 'true' ]]; then
    kernelVersion="$(uname -r)"
    kernelMajor="${kernelVersion%%.*}"
    kernelMinor="${kernelVersion#$kernelMajor.}"
    kernelMinor="${kernelMinor%%.*}"
    kernelPatch="${kernelVersion#*$kernelMinor.}"
    kernelPatch="${kernelPatch%%-*}"
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
    echo -e "  /        /  \\    [] CROSS-ARCH: ${CROSS_ARCH}"
    echo -e " /        /    \\   [] KERNEL: $kernelMajor.$kernelMinor.$kernelPatch"
    echo -e "/________/      \\  [] TIME: $(date | awk '{print $4}')"
    echo -e "\\        \\      /  [] HOSTNAME: $(hostname)"
    echo -e " \\        \\    /   [] ANDROID: $(getprop ro.build.version.release)"
    echo -e "  \\        \\  /    [] CONTAINER_DIR: $(echo ${CONTAINER_DIR} | sed 's#/data/data/com.termux/files/home#$HOME#' | sed 's#/data/data/com.termux/files/usr#$PREFIX#')"
    echo -e "   \\________\\/     [] VERSION: 9.0-dev"
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
  unset LD_PRELOAD
  COMMAND="proot"
  COMMAND+=" --link2symlink"
  COMMAND+=" --kill-on-exit"
  COMMAND+=" --sysvipc"
  COMMAND+=" -0"
  COMMAND+=" -r ${CONTAINER_DIR}"
  COMMAND+=" -b /dev"
  COMMAND+=" -b /sys"
  COMMAND+=" -b /proc"
  COMMAND+=" -w /root"
  if [[ ${MOUNT_SDCARD} = "true" ]]; then
    COMMAND+=" -b /sdcard"
  fi
  if [[ ${CROSS_ARCH} != "null" ]]; then
    COMMAND+=" -q qemu-${CROSS_ARCH}"
  fi
  # From Redmi 10X 5G, I hope it works.
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/buddyinfo:/proc/buddyinfo"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/cgroups:/proc/cgroups"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/consoles:/proc/consoles"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/crypto:/proc/crypto"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/devices:/proc/devices"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/diskstats:/proc/diskstats"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/execdomains:/proc/execdomains"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/fb:/proc/fb"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/filesystems:/proc/filesystems"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/interrupts:/proc/interrupts"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/iomem:/proc/iomem"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/ioports:/proc/ioports"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/kallsyms:/proc/kallsyms"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/key-users:/proc/key-users"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/keys:/proc/keys"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/kpageflags:/proc/kpageflags"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/loadavg:/proc/loadavg"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/locks:/proc/locks"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/misc:/proc/misc"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/modules:/proc/modules"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/pagetypeinfo:/proc/pagetypeinfo"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/partitions:/proc/partitions"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/sched_debug:/proc/sched_debug"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/softirqs:/proc/softirqs"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/stat:/proc/stat"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/timer_list:/proc/timer_list"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/uptime:/proc/uptime"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/version:/proc/version"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/vmallocinfo:/proc/vmallocinfo"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/vmstat:/proc/vmstat"
  COMMAND+=" --mount=$PREFIX/share/termux-container/proc/zoneinfo:/proc/zoneinfo"
  # Mount termux's tmpdir.
  COMMAND+=" --mount=$PREFIX/tmp:/tmp"
  COMMAND+=" /bin/su - root"
  printf "\033[0m"
  ${COMMAND}
}
