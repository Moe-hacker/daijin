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

# Just like `docker rmi`?
# Usage:
# remove_image OS_DISTRO VERSION (CPU_ARCH)
OS=$1
VERSION=$2
CPU_ARCH=$3
if [[ ${CPU_ARCH} == "" ]]; then
  get_cpu_arch
fi
if [[ -e $PREFIX/var/container/${OS}-${VERSION}-${CPU_ARCH}.tar.xz ]]; then
  rm -fv $PREFIX/var/container/${OS}-${VERSION}-${CPU_ARCH}.tar.xz
else
  echo -e "\033[31mError: Rootfs does not exist !${COLOR}"
fi
