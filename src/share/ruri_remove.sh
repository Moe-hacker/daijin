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
CONFIG_FILE=$1
if [[ ! -e ${CONFIG_FILE} ]]; then
  echo -e "\033[31mError: cannot find config file.\033[0m" >&2
  exit 1
fi
source ${CONFIG_FILE}
CONTAINER_DIR=$container_dir
# Show warning.
echo -e "\n\n\033[33mWarning: please reboot your device before removing the container."
echo "I am not responsible for anything that may happen to your device by using this script !!!"
# Remove container.
echo -e "\n\n"
echo "Press CTRL-C to cancel this script"
echo "Or press yes to remove this container"
read -p "=> " i
if [[ $i != "yes" ]]; then
  echo "exit"
  exit 0
fi
if [[ ${CONTAINER_DIR} == "" ]] || [[ ${CONTAINER_DIR} == "/" ]]; then
  exit 1
fi
# Umount.
sudo ruri -U ${CONTAINER_DIR}
# Remove.
echo "This is the last chance to regret it"
echo "Press CTRL-C to cancel this script"
echo "Or press enter to continue"
read i
sudo rm -rvf ${CONTAINER_DIR}
sudo rm ${CONFIG_FILE}
