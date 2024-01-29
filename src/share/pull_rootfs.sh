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
# $MIRROR

# It will set the following variable(s):
# $ROOTFS
mkdir -p /data/data/com.termux/files/usr/var/daijin/rootfs
rootfslist=$(rootfstool l -m $MIRROR | awk '{print $2}')
j=1
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
if [[ ! -e /data/data/com.termux/files/usr/var/daijin/rootfs/$distro-$version.tar.xz ]];then
cd /data/data/com.termux/files/usr/tmp
rm rootfs.tar.xz*
axel -n 16 $(rootfstool u  -d $distro -v $version -m $MIRROR)
mv rootfs.tar.xz /data/data/com.termux/files/usr/var/daijin/rootfs/$distro-$version.tar.xz
fi
export ROOTFS=/data/data/com.termux/files/usr/var/daijin/rootfs/$distro-$version.tar.xz
