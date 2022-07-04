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

# Just call to other functions.
function run_container() {
  CONTAINER_NAME=$1
  if [[ -e $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf ]]; then
    RUN_PROOT_CONTAINER ${CONTAINER_NAME}
  elif [[ -e $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf ]]; then
    if [[ $(whoami) != "root" ]]; then
      sudo container -e RUN_CHROOT_CONTAINER ${CONTAINER_NAME}
      return
    fi
  else
    echo -e "\033[31mError: container does not exist !${COLOR}"
    return
  fi
}
