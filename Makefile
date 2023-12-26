# SPDX-License-Identifier: Apache-2.0
#
# This file is part of termux-container, with ABSOLUTELY NO WARRANTY.
#
# Copyright (c) 2021-2023 Moe-hacker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
O = out
.PHONY: all
all: show-logo install-dependence update-code build
show-logo:
	@printf "\033[1;38;2;254;228;208m"
	@printf "        ●●●●● ●●●●● ●●●●  ●   ● ●   ● ●   ●\n"
	@printf "          ●   ●     ●   ● ●● ●● ●   ●  ● ●\n"
	@printf "          ●   ●●●●  ●●●●  ● ● ● ●   ●   ●\n"
	@printf "          ●   ●     ●  ●  ●   ● ●   ●  ● ●\n"
	@printf "          ●   ●●●●● ●   ● ●   ●  ●●●  ●   ●\n"
	@echo
	@echo
	@printf " ●●●   ●●●  ●   ● ●●●●●   ●    ●●●  ●   ● ●●●●● ●●●●\n"
	@printf "●   ● ●   ● ●●  ●   ●    ● ●    ●   ●●  ● ●     ●   ●\n"
	@printf "●     ●   ● ● ● ●   ●   ●   ●   ●   ● ● ● ●●●●  ●●●●\n"
	@printf "●   ● ●   ● ●  ●●   ●   ●●●●●   ●   ●  ●● ●     ●  ●\n"
	@printf " ●●●   ●●●  ●   ●   ●   ●   ●  ●●●  ●   ● ●●●●● ●   ●\n"
	@echo
install-dependence:
	@printf "\033[1;38;2;254;228;208m[+] Install dependents.\033[0m\n"&&sleep 1s
	@pkg install ndk-multilib-native-static tsu coreutils p7zip gettext tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk clang ndk-sysroot ndk-multilib libc-client-static libcap-static binutils libseccomp-static golang
build:update-code
	@printf "\033[1;38;2;254;228;208m[+] Build.\033[0m\n"&&sleep 1s
	@make -C src
	@mkdir -pv $(O)
	@mkdir -pv $(O)/doc/termux-container
	@mkdir -pv $(O)/share/termux-container
	@cp -rv doc/* $(O)/doc/termux-container/
	@cp -rv share $(O)/share/termux-container
	@mkdir -pv $(O)/etc/container
	@mkdir -pv $(O)/bin/
	@cp -v src/container $(O)/bin/container
	@cp -v src/rootfstool/rootfstool $(O)/bin/rootfstool
	@mv -v src/container-console/container-console $(O)/bin/container-console
	@mv -v src/ruri/ruri $(O)/bin/ruri
	@mv -v src/yoshinon/yoshinon $(O)/bin/yoshinon
	@mv -v src/nekoasc/nekoasc $(O)/bin/nekoasc
update-code:
	@printf "\033[1;38;2;254;228;208m[+] Update code.\033[0m\n"&&sleep 1s
	@git submodule update --init
install:build
	@printf "\033[1;38;2;254;228;208m[+] Install.\033[0m\n"&&sleep 1s
	@cp -v $(O)/bin/* /data/data/com.termux/files/usr/bin/
	@cp -rv $(O)/etc/* /data/data/com.termux/files/usr/etc/
	@cp -rv $(O)/share/termux-container /data/data/com.termux/files/usr/share/
	@cp -rv $(O)/doc/* /data/data/com.termux/files/usr/share/doc
pack-deb:
	@mkdir -v $(O)/deb
	@mkdir -pv $(O)/deb/data/data/com.termux/files/usr
	@mkdir -pv $(O)/deb/data/data/com.termux/files/usr/bin/
	@mkdir -pv $(O)/deb/data/data/com.termux/files/usr/share/
	@mkdir -pv $(O)/deb/data/data/com.termux/files/usr/share/doc
	@mkdir -pv $(O)/deb/data/data/com.termux/files/usr/etc
	@mkdir -pv $(O)/deb/data/data/com.termux/files/home/.termux
	@cp -rv $(O)/etc/* $(O)/deb/data/data/com.termux/files/usr/etc/
	@cp -v $(O)/bin/* $(O)/deb/data/data/com.termux/files/usr/bin/
	@cp -rv $(O)/share/termux-container $(O)/deb/data/data/com.termux/files/usr/share/
	@cp -rv $(O)/doc/* $(O)/deb/data/data/com.termux/files/usr/share/doc
	@cp -rv dpkg-conf $(O)/deb/DEBIAN
	@printf "\033[1;38;2;254;228;208m[+] Build packages.\033[0m\n"&&sleep 1s
	@cd $(O)/deb&&chmod -Rv 755 DEBIAN&&chmod -Rv 777 data/data/com.termux/files/usr/bin
	@cd $(O)/deb&&dpkg -b . ../../termux-container.deb
	@printf "\033[1;38;2;254;228;208m    .^.   .^.\n"
	@printf "    /⋀\\_ﾉ_/⋀\\ \n"
	@printf "   /ﾉｿﾉ\\ﾉｿ丶)|\n"
	@printf "  |ﾙﾘﾘ >   )ﾘ\n"
	@printf "  ﾉノ㇏ Ｖ ﾉ|ﾉ\n"
	@printf "        ⠁⠁\n"
	@printf "\033[1;38;2;254;228;208m[*] Build done,package: termux-container.deb\033[0m\n"
clean:
	@printf "\033[1;38;2;254;228;208m[+] Clean.\033[0m\n"&&sleep 1s
	@rm -rfv $(O)
	@printf "\033[1;38;2;254;228;208m    .^.   .^.\n"
	@printf "    /⋀\\_ﾉ_/⋀\\ \n"
	@printf "   /ﾉｿﾉ\\ﾉｿ丶)|\n"
	@printf "  |ﾙﾘﾘ >   )ﾘ\n"
	@printf "  ﾉノ㇏ Ｖ ﾉ|ﾉ\n"
	@printf "        ⠁⠁\n"
	@printf "\033[1;38;2;254;228;208m[*] Cleaned Up.\033[0m\n"
gnu-dev :
	sudo mkdir -pv /data/data/com.termux/files
	sudo mkdir -pv /data/data/com.termux/files/usr/bin
	sudo mkdir -pv /data/data/com.termux/files/usr/etc
	sudo mkdir -pv /data/data/com.termux/files/usr/var
	sudo mkdir -pv /data/data/com.termux/files/home
	sudo ln -svf /usr/bin /data/data/com.termux/files/usr/bin
	sudo chmod -v 777 /data/data/com.termux/files/usr/bin
	sudo chmod -Rv 777 /data
	cp -frav `realpath .` /data/data/com.termux/files/home/
	printf "\033[1;38;2;254;228;208m[*] Go to /data/data/com.termux/files/home/termux-container for dev environment\n"
help :
	@echo "Available commands:"
	@echo "make build    :Just build"
	@echo "make install  :Build and install"
	@echo "make pack-deb :Build .deb package"
