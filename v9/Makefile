all :
	@printf "\033[1;38;2;254;228;208m"
	@printf "\033[1;38;2;254;228;208m[+] Install depends.\033[0m\n"&&sleep 1s
	@pkg install tsu coreutils p7zip tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk clang ndk-sysroot ndk-multilib libc-client-static libcap-static
	@printf "\033[1;38;2;254;228;208m[+] Copy source code.\033[0m\n"&&sleep 1s
	@mkdir -pv build&&sleep 0.5s
	@cd build&&mkdir -pv data/data/com.termux/files
	@cd build&&cp ../src/usr data/data/com.termux/files/ -rv
	@cd build&&cp ../src/DEBIAN . -rv
	@printf "\033[1;38;2;254;228;208m[+] Compile moe-container.\033[0m\n"&&sleep 1s
	@cd build&&git clone https://github.com/Moe-hacker/moe-container
	@cd build&&cd moe-container&&make static&&mv -v container ../data/data/com.termux/files/usr/bin/moe-container
	@cd build&&rm -rfv moe-container
	@printf "\033[1;38;2;254;228;208m[+] Build package.\033[0m\n"&&sleep 1s
	@cd build&&chmod -Rv 755 DEBIAN
	@cd build&&dpkg -b . ../termux-container.deb
	@printf "\033[1;38;2;254;228;208m[+] Clean.\033[0m\n"&&sleep 1s
	@rm -rfv build
help :
	@echo "Makefile is not for common user here,please use released .deb file instead."
	@echo "(>_)"
