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

function script_help() {
  col=$(($(($(stty size | awk '{print $2}'))) / 2 - 25))
  logo="\033[1;38;2;254;228;208m
\033[${col}G         ●●●●● ●●●●● ●●●●  ●   ● ●   ● ●   ●
\033[${col}G           ●   ●     ●   ● ●● ●● ●   ●  ● ●
\033[${col}G           ●   ●●●●  ●●●●  ● ● ● ●   ●   ●
\033[${col}G           ●   ●     ●  ●  ●   ● ●   ●  ● ●
\033[${col}G           ●   ●●●●● ●   ● ●   ●  ●●●  ●   ●



\033[${col}G ●●●   ●●●  ●   ● ●●●●●   ●    ●●●  ●   ● ●●●●● ●●●●
\033[${col}G●   ● ●   ● ●●  ●   ●    ● ●    ●   ●●  ● ●     ●   ●
\033[${col}G●     ●   ● ● ● ●   ●   ●   ●   ●   ● ● ● ●●●●  ●●●●
\033[${col}G●   ● ●   ● ●  ●●   ●   ●●●●●   ●   ●  ●● ●     ●  ●
\033[${col}G ●●●   ●●●  ●   ●   ●   ●   ●  ●●●  ●   ● ●●●●● ●   ●

"
  printf "$logo"
  SIZE=$(stty size | awk '{print $2}')
  let SIZE=$(($SIZE - 16))
  echo "//"
  echo
  echo -e "\e[30;1;48;2;254;228;208;38;2;0;0;0mTERMUX-CONTAINER$(yes " " | sed $SIZE'q' | tr -d '\n')\033[0m"
  echo
  echo -e "${COLOR}//"
  echo
  echo -e "Usage:"
  echo -e " container                       #Start container console."
  echo -e " container -h                    #Show this page."
  echo -e " container cp [Name:Path] [Path] #Copy files,like docker cp."
  echo -e " container -i [Image File]       #Import an image."
  echo -e " container -E                    #Easy mode."
  echo -e " container -e [Function]         #Exec function in this script *NOT for user."
}
# Help page for container-console.
function console_help() {
  # Usage:
  # console_help
  # I hope you can understand...
  echo -e "${COLOR}Usage:"
  echo "  help                       :Show this page."
  echo "  exit                       :Exit console."
  echo "  new                        :Create a new container."
  echo "  search [all/OS] (Arch)     :Search for images."
  echo "  pull [OS] [Version] (Arch) :Download image,just save."
  echo "  rmi [OS] [Version] (Arch)  :Remove an image."
  echo "  cp [Name:Path] [Path]      :Copy files,like docker cp."
  echo "  ls                         :List containers and images."
  echo "  rm [Name]                  :Remove a container."
  echo "  login [Name]               :Login to the container."
  echo "  import [Image File]        :Import an image."
  echo "  export [Name]              :Export a container as an image."
  echo "  info                       :Show version && system info."
}
