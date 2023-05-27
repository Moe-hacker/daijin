O = out
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
update-code:
	@printf "\033[1;38;2;254;228;208m[+] Update source code.\033[0m\n"&&sleep 1s
	git pull
	@git submodule update --init
	@printf "\033[1;38;2;254;228;208m[+] Copy source code.\033[0m\n"&&sleep 1s
build:
	@ls out>/dev/null||mkdir -pv $(O)&&sleep 0.5s&&ls out/deb||mkdir -pv $(O)/deb
	@cd $(O)/deb&&ls data>/dev/null||mkdir -pv data/data/com.termux/files
	@cd $(O)/deb&&ls data/data/com.termux/files/usr>/dev/null||cp ../../src/usr data/data/com.termux/files/ -rv
	@cd $(O)/deb&&ls DEBIAN>/dev/null||cp ../../src/DEBIAN . -rv
	@printf "\033[1;38;2;254;228;208m[+] Compile ruri.\033[0m\n"&&sleep 1s
	@cd $(O)&&cp ../src/ruri . -rv&&cd ruri&&make static&&cp -rv ruri ../deb/data/data/com.termux/files/usr/bin/ruri
	@printf "\033[1;38;2;254;228;208m[+] Compile container-console.\033[0m\n"&&sleep 1s
	@cd src&&make
	@cd $(O)&&cp ../src/container-console ./deb/data/data/com.termux/files/usr/bin/ -v
ifneq ($(shell test -d $(O)||echo x),)
install: all
else
install:
endif
	install $(O)/deb/data/data/com.termux/files/usr/bin/* /data/data/com.termux/files/usr/bin/
	install -d $(O)/deb/data/data/com.termux/files/usr/share/termux-container /data/data/com.termux/files/usr/share
	install -d $(O)/deb/data/data/com.termux/files/usr/share/doc/* /data/data/com.termux/files/usr/share/doc
ifneq ($(shell test -d $(O)||echo x),)
pack-deb: all
else
pack-deb:
endif
	@printf "\033[1;38;2;254;228;208m[+] Build package.\033[0m\n"&&sleep 1s
	@cd $(O)/deb&&chmod -Rv 755 DEBIAN&&chmod -Rv 777 data/data/com.termux/files/usr/bin
	@cd $(O)/deb&&dpkg -b . ../termux-container.deb
	@printf "\033[1;38;2;254;228;208m    .^.   .^.\n"
	@printf "    /⋀\\_ﾉ_/⋀\\ \n"
	@printf "   /ﾉｿﾉ\\ﾉｿ丶)|\n"
	@printf "  |ﾙﾘﾘ >   )ﾘ\n"
	@printf "  ﾉノ㇏ Ｖ ﾉ|ﾉ\n"
	@printf "        ⠁⠁\n"
	@printf "\033[1;38;2;254;228;208m[*] Build done,package: $(O)/termux-container.deb\033[0m\n"
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
help :
	@echo "Makefile is not for common user here,please use released .deb file instead."
	@echo "(>_) Moe-hacker"
