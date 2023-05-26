.PHONY: all build
all: install-dependence update-code build

install-dependence:/data/data/com.termux/files/usr/bin/pkg
	@printf "\033[1;38;2;254;228;208m"
	@printf "                  _________\n"
	@printf "                 /        /\\ \n"
	@printf "                /        /  \\ \n"
	@printf "               /        /    \\ \n"
	@printf "              /________/      \\ \n"
	@printf "              \\        \\      /\n"
	@printf "               \\        \\    /\n"
	@printf "                \\        \\  /\n"
	@printf "                 \\________\\/\n"
	@printf "═╔╝╔═╝╔═║╔╔ ║ ║║ ║  ╔═╝╔═║╔═ ═╔╝╔═║╝╔═ ╔═╝╔═║\n"
	@printf " ║ ╔═╝╔╔╝║║║║ ║ ╝ ═╝║  ║ ║║ ║ ║ ╔═║║║ ║╔═╝╔╔╝\n"
	@printf " ╝ ══╝╝ ╝╝╝╝══╝╝ ╝  ══╝══╝╝ ╝ ╝ ╝ ╝╝╝ ╝══╝╝ ╝\n\n"
	@printf "\033[1;38;2;254;228;208m[+] Install dependents.\033[0m\n"&&sleep 1s
	@pkg install ndk-multilib-native-static tsu coreutils p7zip gettext tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk clang ndk-sysroot ndk-multilib libc-client-static libcap-static binutils
update-code:/data/data/com.termux/files/usr/bin/git
	@printf "\033[1;38;2;254;228;208m[+] Update source code.\033[0m\n"&&sleep 1s
	git pull
	@git submodule update --init
	@printf "\033[1;38;2;254;228;208m[+] Copy source code.\033[0m\n"&&sleep 1s
build:
	@mkdir -pv build&&sleep 0.5s
	@cd build&&mkdir -pv data/data/com.termux/files
	@cd build&&cp ../src/usr data/data/com.termux/files/ -rv
	@cd build&&cp ../src/DEBIAN . -rv
	@printf "\033[1;38;2;254;228;208m[+] Compile ruri.\033[0m\n"&&sleep 1s
	@cd build&&cp ../src/ruri . -rv&&cd ruri&&make static&&mv -v ruri ../data/data/com.termux/files/usr/bin/ruri
	@cd build&&rm -rfv ruri
	@printf "\033[1;38;2;254;228;208m[+] Compile container-console.\033[0m\n"&&sleep 1s
	@cd src&&make
	@cd build&&cp ../src/container-console ./data/data/com.termux/files/usr/bin/ -v
install:all
	install build/data/data/com.termux/files/usr/bin/* /data/data/com.termux/files/usr/bin/
	install -d build/data/data/com.termux/files/usr/share/termux-container /data/data/com.termux/files/usr/share
	install -d build/data/data/com.termux/files/usr/share/doc/* /data/data/com.termux/files/usr/share/doc
pack-deb:all
	@printf "\033[1;38;2;254;228;208m[+] Build package.\033[0m\n"&&sleep 1s
	@cd build&&chmod -Rv 755 DEBIAN&&chmod -Rv 777 data/data/com.termux/files/usr/bin
	@cd build&&dpkg -b . ../termux-container.deb
	@printf "\033[1;38;2;254;228;208m    .^.   .^.\n"
	@printf "    /⋀\\_ﾉ_/⋀\\ \n"
	@printf "   /ﾉｿﾉ\\ﾉｿ丶)|\n"
	@printf "  |ﾙﾘﾘ >   )ﾘ\n"
	@printf "  ﾉノ㇏ Ｖ ﾉ|ﾉ\n"
	@printf "        ⠁⠁\n"
	@printf "\033[1;38;2;254;228;208m[*] Build done,package: ./termux-container.deb\033[0m\n"
clean:
	@printf "\033[1;38;2;254;228;208m[+] Clean.\033[0m\n"&&sleep 1s
	@rm -rfv build
	@printf "\033[1;38;2;254;228;208m    .^.   .^.\n"
	@printf "    /⋀\\_ﾉ_/⋀\\ \n"
	@printf "   /ﾉｿﾉ\\ﾉｿ丶)|\n"
	@printf "  |ﾙﾘﾘ >   )ﾘ\n"
	@printf "  ﾉノ㇏ Ｖ ﾉ|ﾉ\n"
	@printf "        ⠁⠁\n"
	@printf "\033[1;38;2;254;228;208m[*] Cleaned Up.\033[0m\n"
help :
	@echo "Makefile is not for common user here,please use released .deb file instead."
	@echo "(>_) Moe-hacker"
