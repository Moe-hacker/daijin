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

function search_images() {
  # Usage:
  # search_images OS (CPU_ARCH)
  OS=$1
  if [[ $1 == "all" ]]; then
    list_images $2
    return 0
  fi
  if [[ $2 = "" ]]; then
    get_cpu_arch
  else
    CPU_ARCH=$2
  fi
  echo
  rootfstool search -a $CPU_ARCH -d $OS -m $ROOTFS_MIRROR
}
function list_images() {
  # Usage:
  # list_images (CPU_ARCH)
  if [[ $1 = "" ]]; then
    get_cpu_arch
  else
    CPU_ARCH=$1
  fi
  echo
  rootfstool list -a $CPU_ARCH -m $ROOTFS_MIRROR
}
