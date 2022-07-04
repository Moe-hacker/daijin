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
# Just like the command `docker cp`.
# Usage:
# container_cp container_name:/path/in/container /path/in/host
# container_cp /path/in/host container_name:/path/in/container
# container_name should not include character `/`
printf "${COLOR}"
if [[ $1 == *:/* ]]; then
  CONTAINER_NAME=$(echo $1 | cut -d ":" -f 1)
  CONTAINER_PATH=$(echo $1 | cut -d ":" -f 2)
  HOST_PATH=$2
  CP_MODE=1
else
  CONTAINER_NAME=$(echo $2 | cut -d ":" -f 1)
  CONTAINER_PATH=$(echo $2 | cut -d ":" -f 2)
  HOST_PATH=$1
  CP_MODE=2
fi
if [[ -e $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf ]]; then
  source $PREFIX/etc/container/proot/container-${CONTAINER_NAME}.conf
  if [[ $CP_MODE == 1 ]]; then
    cp ${CONTAINER_DIR}${CONTAINER_PATH} ${HOST_PATH}
  else
    cp ${HOST_PATH} ${CONTAINER_DIR}${CONTAINER_PATH}
  fi
elif [[ -e $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf ]]; then
  source $PREFIX/etc/container/chroot/container-${CONTAINER_NAME}.conf
  if [[ $CP_MODE == 1 ]]; then
    sudo cp ${CONTAINER_DIR}${CONTAINER_PATH} ${HOST_PATH}
  else
    sudo cp ${HOST_PATH} ${CONTAINER_DIR}${CONTAINER_PATH}
  fi
else
  echo -e "\033[31mError: container does not exist !${COLOR}"
  return
fi
