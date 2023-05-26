.PHONY: all 
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
	@pkg install ndk-multilib-native-static tsu coreutils p7zip gettext tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk whiptail clang ndk-sysroot ndk-multilib libc-client-static libcap-static binutils
update-code:/data/data/com.termux/files/usr/bin/git
	@printf "\033[1;38;2;254;228;208m[+] Update source code.\033[0m\n"&&sleep 1s
	git pull
	@git submodule update --init
	@printf "\033[1;38;2;254;228;208m[+] Copy source code.\033[0m\n"&&sleep 1s
build:
	@mkdir -pv out&&sleep 0.5s&& mkdir -pv out/deb 
	@cd out/deb&&mkdir -pv data/data/com.termux/files
	@cd out/deb&&cp ../../src/usr data/data/com.termux/files/ -rv
	@cd out/deb&&cp ../../src/DEBIAN . -rv
	@printf "\033[1;38;2;254;228;208m[+] Compile ruri.\033[0m\n"&&sleep 1s
	@cd out&&cp ../src/ruri . -rv&&cd ruri&&make static&&cp -rv ruri ../deb/data/data/com.termux/files/usr/bin/ruri
	@printf "\033[1;38;2;254;228;208m[+] Compile container-console.\033[0m\n"&&sleep 1s
	@cd src&&make
	@cd out&&cp ../src/container-console ./deb/data/data/com.termux/files/usr/bin/ -v
install:out
	install out/data/data/com.termux/files/usr/bin/* /data/data/com.termux/files/usr/bin/
	install -d out/data/data/com.termux/files/usr/share/termux-container /data/data/com.termux/files/usr/share
	install -d out/data/data/com.termux/files/usr/share/doc/* /data/data/com.termux/files/usr/share/doc
pack-deb:out/deb
	@printf "\033[1;38;2;254;228;208m[+] Build package.\033[0m\n"&&sleep 1s
	@cd out&&chmod -Rv 755 DEBIAN&&chmod -Rv 777 data/data/com.termux/files/usr/bin
	@cd out&&dpkg -b . ../termux-container.deb
	@printf "\033[1;38;2;254;228;208m    .^.   .^.\n"
	@printf "    /⋀\\_ﾉ_/⋀\\ \n"
	@printf "   /ﾉｿﾉ\\ﾉｿ丶)|\n"
	@printf "  |ﾙﾘﾘ >   )ﾘ\n"
	@printf "  ﾉノ㇏ Ｖ ﾉ|ﾉ\n"
	@printf "        ⠁⠁\n"
	@printf "\033[1;38;2;254;228;208m[*] Build done,package: ./termux-container.deb\033[0m\n"
clean:
	@printf "\033[1;38;2;254;228;208m[+] Clean.\033[0m\n"&&sleep 1s
	@rm -rfv out
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
