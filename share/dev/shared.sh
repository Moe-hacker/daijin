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
#
# Version info.
# To be 9.5 now because I rewrote it twice since 8.0.
export TERMUX_CONTAINER_VERSION="9.5-dev"
export TERMUX_CONTAINER_LICENSE="Apache-2.0"
# Will be automatically set by Makefile.
export TERMUX_CONTAINER_COMMIT_ID=""
# Output main color.
RGB_COLOR="254;228;208"
export COLOR="\033[1;38;2;${RGB_COLOR}m"
# A very cute catgirl nya~~~
export CAT1="\n${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ Ｖ ﾉ|ﾉ
      ⠁⠁
"
export CAT2="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏  ^ ﾉ|ﾉ
      ⠁⠁
"
export CAT3="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ ぁ ﾉ|ﾉ
      ⠁⠁
"
export CAT4="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ の ﾉ|ﾉ
      ⠁⠁
"
export CAT5="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ ヮ ﾉ|ﾉ
      ⠁⠁
"
export CAT6="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ ++ ﾉ|ﾉ
      ⠁⠁
"
export CAT7="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ xx ﾉ|ﾉ
      ⠁⠁
"
export CAT8="${COLOR}  .^.   .^.
  /⋀\_ﾉ_/⋀\\
 /ﾉｿﾉ\ﾉｿ丶)|
|ﾙﾘﾘ >   )ﾘ
ﾉノ㇏ ひ ﾉ|ﾉ
      ⠁⠁
"

# Show error message and exit.
function error() {
  # Usage:
  # error "Error message"
  echo -e "\033[31m$@\033[0m" >&2
  printf "${COLOR}${CAT2}\033[0m" >&2
  echo -e "${COLOR}If you think something is wrong, please report at:\n\033[4mhttps://github.com/Moe-hacker/termux-container/discussions\033[0m" >&2
  exit 1
}
# From Tmoe.
# In fact I don't think that there are any phones with amd64 CPUS and Android system now.
function get_cpu_arch() {
  # Usage:
  # get_cpu_arch
  # It will create a global variable ${CPU_ARCH}
  DPKG_ARCH=$(dpkg --print-architecture)
  case ${DPKG_ARCH} in
  armel) export CPU_ARCH="armel" ;;
  armv7* | armv8l | armhf | arm) export CPU_ARCH="armhf" ;;
  aarch64 | arm64* | armv8* | arm*) export CPU_ARCH="arm64" ;;
  i*86 | x86) export CPU_ARCH="i386" ;;
  x86_64 | amd64) export CPU_ARCH="amd64" ;;
  *) echo -e "\033[31mUnknow cpu architecture for this device !\033[0m" && exit 1 ;;
  esac
}
