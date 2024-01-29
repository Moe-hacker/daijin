#!/data/data/com.termux/files/usr/bin/bash
# Copyright 2024 moe-hacker
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
#

# You need to set the following variable(s)
# before running this script:
#
# $CONTAINER_DIR
# $MOUNT_SDCARD
# $CROSS_ARCH
# $EXTRA_ARGS

# A simple proot script.
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
# Files extracted from Redmi 10X 5G, I hope it works.
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
# Extra args.
COMMAND+=" ${EXTRA_ARGS}"
if [[ ! $1 ]]; then
  COMMAND+=" /bin/su - root"
else
  COMMAND+=" $@"
fi
# Yes, this can exec the command.
${COMMAND}
