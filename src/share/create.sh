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
function pull_rootfs() {
  # It will set the following variable(s):
  # $ROOTFS
  # $NAME
  # $CONTAINER_DIR
  mkdir -p /data/data/com.termux/files/usr/var/daijin/rootfs 2>&1 >/dev/null || true
  mirrorlist=$(rootfstool m)
  j=1
  for i in $mirrorlist; do
    arg+="[$j] $i "
    j=$((j + 1))
  done
  num=$(yoshinon --menu --cursorcolor "114;5;14" --title "DAIJIN-$VERSION" "Select a mirror" 12 25 4 $arg)
  num=$(echo $num | cut -d "[" -f 2 | cut -d "]" -f 1)
  distro=$(echo $mirrorlist | cut -d " " -f $num)
  rootfslist=$(rootfstool l -m $MIRROR | awk '{print $2}')
  j=1
  arg=""
  for i in $rootfslist; do
    arg+="[$j] $i "
    j=$((j + 1))
  done
  num=$(yoshinon --menu --cursorcolor "114;5;14" --title "DAIJIN-$VERSION" "Select a distro" 12 25 4 $arg)
  num=$(echo $num | cut -d "[" -f 2 | cut -d "]" -f 1)
  distro=$(echo $rootfslist | cut -d " " -f $num)
  versionlist=$(rootfstool s -d $distro -m $MIRROR | awk '{print $4}')
  j=1
  arg=""
  for i in $versionlist; do
    arg+="[$j] $i "
    j=$((j + 1))
  done
  num=$(yoshinon --menu --cursorcolor "114;5;14" --title "DAIJIN-$VERSION" "Select the version" 12 25 4 $arg)
  num=$(echo $num | cut -d "[" -f 2 | cut -d "]" -f 1)
  version=$(echo $versionlist | cut -d " " -f $num)
  if [[ ! -e /data/data/com.termux/files/usr/var/daijin/rootfs/$distro-$version.tar.xz ]]; then
    cd /data/data/com.termux/files/usr/tmp
    rm rootfs.tar.xz*
    axel -n 16 $(rootfstool u -d $distro -v $version -m $MIRROR)
    mv rootfs.tar.xz /data/data/com.termux/files/usr/var/daijin/rootfs/$distro-$version.tar.xz
  fi
  export ROOTFS=/data/data/com.termux/files/usr/var/daijin/rootfs/$distro-$version.tar.xz
  export CONTAINER_DIR=/data/data/com.termux/files/home/$distro-$version-$(date +%s)
  export NAME=$distro-$version-$(date +%s)
}
function create_ruri_container() {
  sudo mkdir -p ${CONTAINER_DIR}
  pv ${ROOTFS} | sudo tar -xJf - -C ${CONTAINER_DIR}
  unset LD_PRELOAD
  cp /data/data/com.termux/files/usr/share/daijin/fixup.sh ${CONTAINER_DIR}/tmp/
  sudo ruri ${CONTAINER_DIR} /tmp/fixup.sh
  sudo ruri -D -o /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf ${CONTAINER_DIR}
  sudo chmod 777 /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf
  printf "backend=\"ruri\"\n" | sudo tee -a /data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf 2>&1 >/dev/null
}
function create_proot_container() {
  mkdir -p ${CONTAINER_DIR}
  pv ${ROOTFS} | tar -xJf - -C ${CONTAINER_DIR}
  unset LD_PRELOAD
  cp /data/data/com.termux/files/usr/share/daijin/fixup.sh ${CONTAINER_DIR}/tmp/
  cp /data/data/com.termux/files/usr/share/daijin/fixup.sh /data/data/com.termux/files/usr/tmp/
  /data/data/com.termux/files/usr/share/daijin/proot_start.sh -r ${CONTAINER_DIR} /tmp/fixup.sh
  printf "backend=\"proot\"\ncontainer_dir=\"${CONTAINER_DIR}\"\n" >/data/data/com.termux/files/usr/var/daijin/containers/${NAME}.conf
}
function main() {
  mkdir -p /data/data/com.termux/files/usr/var/daijin/containers/
  if [[ $1 == "-r" ]]; then
    backend=$(yoshinon --menu --cursorcolor "114;5;14" --title "DAIJIN-$VERSION" "choose the backend" 12 25 4 "[1]" "ruri" "[2]" "proot")
    if [[ $backend == "[1]" ]]; then
      backend=ruri
    else
      backend=proot
    fi
  else
    backend=proot
  fi
  pull_rootfs
  if [[ $backend == "ruri" ]]; then
    create_ruri_container
  else
    create_proot_container
  fi
}
main $@
