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
function create_ruri_container() {
  if [[ $(whoami) != "root" ]]; then
    sudo bash /data/data/com.termux/files/usr/share/daijin/create_rurima.sh re-exec
  fi
  source /data/data/com.termux/files/usr/share/daijin/rurima_pull.sh
  rurima_pull_rootfs
  unset LD_PRELOAD
  cp /data/data/com.termux/files/usr/share/daijin/fixup.sh ${CONTAINER_DIR}/tmp/
  chmod 777 ${CONTAINER_DIR}/tmp/fixup.sh
  rurima r ${CONTAINER_DIR} /bin/sh /tmp/fixup.sh
  rurima r -D -o /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf ${CONTAINER_DIR}
  chmod 777 /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf
  printf "backend=\"ruri\"\n" | tee -a /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf 2>&1 >/dev/null
}
function create_proot_container() {
  source /data/data/com.termux/files/usr/share/daijin/rurima_pull.sh
  rurima_pull_rootfs
  unset LD_PRELOAD
  cp /data/data/com.termux/files/usr/share/daijin/fixup.sh ${CONTAINER_DIR}/tmp/
  cp /data/data/com.termux/files/usr/share/daijin/fixup.sh /data/data/com.termux/files/usr/tmp/
  chmod 777 ${CONTAINER_DIR}/tmp/fixup.sh
  chmod 777 /data/data/com.termux/files/usr/tmp/fixup.sh
  /data/data/com.termux/files/usr/share/daijin/proot_start.sh -r ${CONTAINER_DIR} /tmp/fixup.sh
  printf "backend=\"proot\"\ncontainer_dir=\"${CONTAINER_DIR}\"\n" >/data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf
}
function main() {
  mkdir -p /data/data/com.termux/files/usr/var/daijin/containers/
  if [[ $1 == "re-exec" ]]; then
    create_ruri_container
    exit 0
  fi
  if [[ $1 == "-r" ]]; then
    echo -e "[1] ruri \n[2] proot"
    backend=$(select_range "choose the backend" 1 2)
    check_if_succeed $?
    if [[ $backend == "[1]" ]]; then
      backend=ruri
    else
      backend=proot
    fi
  else
    backend=proot
  fi
  if [[ $backend == "ruri" ]]; then
    create_ruri_container
  else
    create_proot_container
  fi
}
# For function rurima_pull_rootfs
main $@
