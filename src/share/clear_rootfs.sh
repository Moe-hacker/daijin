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
# Show warning.
echo -e "\033[33m"
echo "rootfs are downloaded to /data/data/com.termux/files/usr/var/daijin/rootfs/"
# Remove container.
echo -e "\n\n"
echo "Press CTRL-C to cancel this script"
echo "Or press enter to remove cached rootfs"
read -p "=>"
sudo rm -rf /data/data/com.termux/files/usr/var/daijin/rootfs/*
rm -rf /data/data/com.termux/files/usr/var/daijin/rootfs/*
