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

# In fact it's very very very useless.
# But it's cool, isn't it?
# Usage:
# show_info
source /data/data/com.termux/files/usr/share/termux-container/shell/shared.sh
logo="\033[1;38;2;254;228;208m
         ●●●●● ●●●●● ●●●●  ●   ● ●   ● ●   ●
           ●   ●     ●   ● ●● ●● ●   ●  ● ●
           ●   ●●●●  ●●●●  ● ● ● ●   ●   ●
           ●   ●     ●  ●  ●   ● ●   ●  ● ●
           ●   ●●●●● ●   ● ●   ●  ●●●  ●   ●



 ●●●   ●●●  ●   ● ●●●●●   ●    ●●●  ●   ● ●●●●● ●●●●
●   ● ●   ● ●●  ●   ●    ● ●    ●   ●●  ● ●     ●   ●
●     ●   ● ● ● ●   ●   ●   ●   ●   ● ● ● ●●●●  ●●●●
●   ● ●   ● ●  ●●   ●   ●●●●●   ●   ●  ●● ●     ●  ●
 ●●●   ●●●  ●   ●   ●   ●   ●  ●●●  ●   ● ●●●●● ●   ●
"
printf "$logo"
echo
echo -e "\nScript Info :"
echo
echo -e "[\ueb11] Activation Stat       : Not Active"
echo -e "[\ue729] Commit ID             : ${TERMUX_CONTAINER_COMMIT_ID}"
echo -e "[\uf46b] Author                : Moe-hacker"
echo -e "[\ue7c4] License               : ${TERMUX_CONTAINER_LICENSE}"
echo -e "[\uf469] Version               : ${TERMUX_CONTAINER_VERSION}"
echo -e "[\uf1d1] ruri Version          : $(ruri -V)"
echo -e "[\ue78b] ruri License          : MIT"
echo -e "[\ue796] rootfstool Version    : $(rootfstool version | head -1 | awk '{print $3}')"
echo -e "[\ue7c4] rootfstool License    : Apache-2.0"
# Learned from moby's check-config.sh.
kernelVersion="$(uname -r)"
kernelMajor="${kernelVersion%%.*}"
kernelMinor="${kernelVersion#$kernelMajor.}"
kernelMinor="${kernelMinor%%.*}"
kernelPatch="${kernelVersion#*$kernelMinor.}"
kernelPatch="${kernelPatch%%-*}"
echo -e "\nSystem Info :"
echo
echo -e "[] Kernel Version        : $kernelMajor.$kernelMinor.$kernelPatch"
if [[ ${TERMUX_VERSION} != "" ]]; then
  echo -e "[\ufcb5] Termux Version        : ${TERMUX_VERSION}"
fi
echo -e "[] Username              : $(whoami)"
echo -e "[\ufc8e] Android Version       : $(getprop ro.build.version.release)"
echo -e "[] Cpu Architecture      : $(uname -m)"
echo -e "[] Hostname              : $(hostname)"
echo -e "[] Uptime                : $(uptime -p)"
su -c true 2>&1 >/dev/null && STAT="rooted" || STAT="not rooted"
echo -e "[] Device Stat           : ${STAT}"
for i in $(ls /proc/$$/ns | grep -v for_children); do
  NS+="$i "
done
echo -e "[\uf013] Supported namespace   : ${NS}"
# XXX: `su -c` will not work properly with kernelSU.
if [[ -e /bin/magisk ]]; then
  echo -e "[\ufd23] Magisk version        : $(su -c /bin/magisk -V)"
  echo -e "[\ufc7e] SELinux               : $(sudo getenforce)"
fi
if [[ -e /data/adb/ksud ]]; then
  echo -e "[\uf639] KernelSU version      : $(sudo /data/adb/ksud -V)"
  echo -e "[\ufc7e] SELinux               : $(sudo getenforce)"
fi
echo -e "\nHardware Info :"
echo
echo -e "[\uf493] Brand                 : $(getprop ro.product.brand)"
echo -e "[\uf493] Model                 : $(getprop ro.product.model)"
echo -e "[] Model Codename        : $(getprop ro.product.board)"
echo -e "[] Platform Codename     : $(getprop ro.board.platform)"
echo -e "[] Cpus                  : $(lscpu | grep CPU\(s\)\: | awk '{print $2}')"
echo -e "[] SOC Model             : $(getprop ro.soc.model)"
echo -e "[] Total Memory          : $(free -g --si | grep "Mem" | awk {'print $2'})GB"
_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
temp=$((_temp / 1000))
if ((temp > 37)); then
  logo=""
else
  logo="\uf2dc"
fi
temp+=".$((_temp % 1000))"
echo -e "[${logo}] Temperature           : ${temp}°C"
echo
