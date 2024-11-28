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
function check_if_succeed() {
  if [[ $1 -ne 0 ]]; then
    echo -e "\033[31mDaijin got an error\033[0m"
    exit 1
  fi
}
function select_range() {
  read -p "$1" range
  if [[ "" == $range ]]; then
    echo $(select_range "$1" $2 $3)
    return
  fi
  if [[ $range -lt $2 || $range -gt $3 ]]; then
    echo $(select_range "$1" $2 $3)
    return
  fi
  echo $range
}
chmod 777 /data/data/com.termux/files/usr/var/daijin/containers/*
if [[ $(ls /data/data/com.termux/files/usr/var/daijin/containers/) == "" ]]; then
  echo -e "\033[31mNo container found\033[0m" >&2
  exit 1
fi
j=1
for i in $(ls /data/data/com.termux/files/usr/var/daijin/containers/); do
  echo -e "[$j] ${i%%.conf} "
  j=$((j + 1))
done
num=$(select_range "Choose the container: " 1 $((j - 1)))
check_if_succeed $?
num=$(echo $num | cut -d "[" -f 2 | cut -d "]" -f 1)
CONFIG_FILE=/data/data/com.termux/files/usr/var/daijin/containers/$(echo $(ls /data/data/com.termux/files/usr/var/daijin/containers/) | cut -d " " -f $num)
source ${CONFIG_FILE}
if [[ ${backend} == "ruri" ]]; then
  sudo mount -o remount,suid /data >/dev/null 2>&1 || true
  sudo rurima r -C ${CONFIG_FILE}
  sudo chmod 777 ${CONFIG_FILE}
  echo "backend=\"ruri\"" >>${CONFIG_FILE}
  sudo LD_PRELOAD= rurima r -c ${CONFIG_FILE}
elif [[ ${backend} == "proot" ]]; then
  /data/data/com.termux/files/usr/share/daijin/proot_start.sh -r $container_dir -e "$extra_args"
else
  echo -e "\033[31mIncorrect config\033[0m" >&2
  exit 1
fi
