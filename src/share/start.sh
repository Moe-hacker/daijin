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
chmod 777 /data/data/com.termux/files/usr/var/daijin/containers/*
if [[ $(ls /data/data/com.termux/files/usr/var/daijin/containers/) == "" ]]; then
  echo -e "\033[31mNo container found\033[0m" >&2
  exit 1
fi
j=1
for i in $(ls /data/data/com.termux/files/usr/var/daijin/containers/); do
  arg+="[$j] ${i%%.conf} "
  j=$((j + 1))
done
num=$(yoshinon --menu --cursorcolor "114;5;14" --title "DAIJIN-$VERSION" "Choose the container" 12 33 4 $arg)
num=$(echo $num | cut -d "[" -f 2 | cut -d "]" -f 1)
CONFIG_FILE=/data/data/com.termux/files/usr/var/daijin/containers/$(echo $(ls /data/data/com.termux/files/usr/var/daijin/containers/) | cut -d " " -f $num)
source ${CONFIG_FILE}
if [[ ${backend} == "ruri" ]]; then
  sudo LD_PRELOAD= ruri -c ${CONFIG_FILE}
elif [[ ${backend} == "proot" ]]; then
  /data/data/com.termux/files/usr/share/daijin/proot_start.sh -r $container_dir -e "$extra_args"
else
  echo -e "\033[31mIncorrect config\033[0m" >&2
  exit 1
fi
