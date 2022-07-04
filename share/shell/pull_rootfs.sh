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

# Most of the code were rewritten to rootfstool.
function pull_rootfs() {
  # Usage:
  # pull_rootfs OS_DISTRO VERSION (CPU_ARCH)
  #TODO
  OS=$1
  VERSION=$2
  printf "${COLOR}"
  if [[ $3 = "" ]]; then
    get_cpu_arch
  else
    CPU_ARCH=$3
  fi
  if [[ -e $PREFIX/var/container/${OS}-${VERSION}-${CPU_ARCH}.tar.xz ]]; then
    echo -e "\033[31mError: Rootfs already exists !")${COLOR}"
    return 1
  fi
  if [[ $OS == "manjaro" ]]; then
    get_manjaro_rootfs
    return 0
  fi
  # XXX:parroros
  mkdir -p $PREFIX/tmp/container
  cd $PREFIX/tmp/container
  rootfstool download -d $OS -v $VERSION -a $CPU_ARCH -m ${ROOTFS_MIRROR}
}
# These code has been kept because I haven't added them to rootfstool.
function get_manjaro_rootfs() {
  # Usage:
  # get_manjaro_rootfs
  proot -0 rm -rf $PREFIX/tmp/container
  mkdir -p $PREFIX/tmp/container
  [[ -e $PREFIX/var/container ]] || mkdir -p $PREFIX/var/container
  cd $PREFIX/tmp/container
  wget https://osdn.net/projects/manjaro-arm/storage/.rootfs/Manjaro-ARM-aarch64-latest.tar.gz
  mkdir manjaro
  proot -0 -l tar -xvf Manjaro-ARM-aarch64-latest.tar.gz -C manjaro
  echo "Server = https://mirrors.bfsu.edu.cn/manjaro/arm-stable/\$repo/\$arch" >manjaro/etc/pacman.d/mirrorlist
  pacmanconf="
[options]
HoldPkg      = pacman glibc manjaro-system
SyncFirst    = manjaro-system manjaro-keyring manjaro-arm-keyring archlinux-keyring archlinuxarm-keyring
Architecture = aarch64


Color
ILoveCandy
CheckSpace

SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional



[core]
SigLevel = Never
Include = /etc/pacman.d/mirrorlist

[extra]
SigLevel = Never
Include = /etc/pacman.d/mirrorlist

[community]
SigLevel = Never
Include = /etc/pacman.d/mirrorlist
"
  # Use proot for devices that are not rooted.
  printf "$pacmanconf" >manjaro/etc/pacman.conf
  rm manjaro/etc/resolv.conf
  echo nameserver 114.114.114.114 >manjaro/etc/resolv.conf
  echo "#!/bin/sh" >>manjaro/tmp/pacman-init.sh
  echo "PATH=\$PATH:\"/sbin:/bin:/usr/bin:/usr/local/bin\"" >>manjaro/tmp/pacman-init.sh
  echo "rm /etc/mtab&&echo / / > /etc/mtab" >>manjaro/tmp/pacman-init.sh
  echo "yes \"\"|pacman-key --init" >>manjaro/tmp/pacman-init.sh
  echo "yes \"\"|pacman -Syyu" >>manjaro/tmp/pacman-init.sh
  echo "rm /etc/mtab&&echo / / > /etc/mtab" >>manjaro/tmp/pacman-init.sh
  echo "yes \"\"|pacman -Syy base base-devel" >>manjaro/tmp/pacman-init.sh
  chmod 777 manjaro/tmp/pacman-init.sh
  COMMAND="proot"
  COMMAND+=" --link2symlink"
  COMMAND+=" --kill-on-exit"
  COMMAND+=" --sysvipc"
  COMMAND+=" -0"
  COMMAND+=" -r $PREFIX/tmp/container/manjaro"
  COMMAND+=" -b /dev"
  COMMAND+=" -b /sys"
  COMMAND+=" -b /proc"
  COMMAND+=" -w /root"
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
  COMMAND+=" --mount=$PREFIX/tmp:/tmp"
  COMMAND+="/bin/sh /tmp/pacman-init.sh"
  unset LD_PRELOAD
  ${COMMAND}
  cd manjaro
  proot -0 -l tar -cvJf ../rootfs.tar.xz .
  mv ../rootfs.tar.xz $PREFIX/var/container/manjaro-current-arm64.tar.xz
  cd ~
  proot -0 rm -rf $PREFIX/tmp/container
}
