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
mkdir -p /data/data/com.termux/files/usr/var/daijin/containers/ 2>&1 >/dev/null
printf "\033[1;38;2;254;228;208m"
read -p "Enter the path of container > " CONTAINER_DIR
CONTAINER_DIR=$(realpath $CONTAINER_DIR)
if [[ ! -e $CONTAINER_DIR ]]; then
  echo -e "\033[31mCannot find the path"
  exit 1
fi
if [[ $1 == -r ]]; then
  echo -e "\033[1;38;2;254;228;208mChoose the backend:"
  read -p "[1] ruri [2] proot > " BACKEND
  if [[ $BACKEND == "1" ]]; then
    BACKEND="ruri"
  else
    BACKEND="proot"
  fi
else
  BACKEND="proot"
fi
read -p "Name the container > " NAME
if [[ -e /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf ]]; then
  echo -e "\033[31mThe name has already been taken"
  exit 1
fi
if [[ $BACKEND == "ruri" ]]; then
  sudo LD_PRELOAD= ruri -D -o /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf $CONTAINER_DIR
  printf "backend=\"ruri\"\n" | sudo tee -a /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf 2>&1 >/dev/null
else
  printf "backend=\"proot\"\ncontainer_dir=\"${CONTAINER_DIR}\"\n" >/data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf
fi
chmod 777 /data/data/com.termux/files/usr/var/daijin/containers/*
echo "\033[1;38;2;254;228;208mRegistered container $NAME"
printf "\033[0m"
