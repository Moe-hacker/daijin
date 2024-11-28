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

# Install dependencies.
printf "\033[1;38;2;254;228;208m"
printf "Install dependencies.\n"
printf "\033[0m"
sleep 1
pkg install ndk-multilib-native-static tsu coreutils p7zip gettext tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk clang ndk-sysroot ndk-multilib libc-client-static libcap-static binutils libseccomp-static golang make
# Update submodule.
printf "\033[1;38;2;254;228;208m"
printf "Init submodules.\n"
printf "\033[0m"
sleep 1
git submodule update --init
# Start build.
printf "\033[1;38;2;254;228;208m"
printf "Build.\n"
printf "\033[0m"
sleep 1
# Create build dir.
mkdir build
mkdir build/DEBIAN
mkdir -p build/data/data/com.termux/files/usr/bin
mkdir -p build/data/data/com.termux/files/usr/share
mkdir -p build/data/data/com.termux/files/usr/share/daijin/proc/
mkdir -p build/data/data/com.termux/files/usr/etc
# Copy dpkg config file.
cp -r dpkg-conf/* build/DEBIAN/
chmod -R 755 build/DEBIAN
# Compile rurima.
cd ../rurima
git submodule update --init
./configure -s
make
cp rurima ../../build/data/data/com.termux/files/usr/bin/
echo "echo \"ruri is built-in in rurima now, please use \`rurima r\` instead\"" >../../build/data/data/com.termux/files/usr/bin/ruri
chmod 777 ../../build/data/data/com.termux/files/usr/bin/ruri
# Copy rootfstool.
cd ../rootfstool
termux-fix-shebang rootfstool
cp rootfstool ../../build/data/data/com.termux/files/usr/bin/
# Return to root dir.
cd ../..
# Copy rurima config file.
cp src/rurima.conf build/data/data/com.termux/files/usr/etc/rurima.conf
# Decompress dummy files of procfs.
tar -xf src/share/proc.tar.xz -C build/data/data/com.termux/files/usr/share/daijin/proc/
# Copy shared sh script.
cp src/share/*.sh build/data/data/com.termux/files/usr/share/daijin/
# Copy daijin main script.
cp src/daijin build/data/data/com.termux/files/usr/bin/
# Fix permission.
chmod 777 build/data/data/com.termux/files/usr/bin/*
chmod 777 build/data/data/com.termux/files/usr/share/daijin/*.sh
cd build
# Set build info.
size=$(du -s . | awk '{printf $1}')
sed -i "s/\[size\]/${size}/" DEBIAN/control
arch=$(dpkg --print-architecture)
sed -i "s/\[arch\]/${arch}/" DEBIAN/control
# Build deb.
dpkg -b . ../daijin-${arch}.deb
# Clean.
cd ..
rm -rf build
# Done.
printf "\033[1;38;2;254;228;208m"
printf "Build done, package: daijin-${arch}.deb\n"
printf "\033[0m"
