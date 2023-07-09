O = out
.PHONY: all
all: show-greetings install-dependence update-code build
show-greetings:
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
install-dependence:
	@printf "\033[1;38;2;254;228;208m[+] Install dependents.\033[0m\n"&&sleep 1s
	@pkg install ndk-multilib-native-static tsu coreutils p7zip gettext tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk whiptail clang ndk-sysroot ndk-multilib libc-client-static libcap-static binutils	
$(O):
ifneq ($(shell test -d $(O)||echo x),)
	@mkdir -v $(O)
endif
DOC = $(O)/doc
$(DOC):$(O)
ifneq ($(shell test -d $(DOC)||echo x),)
	@mkdir -pv $(DOC)/termux-container
	@cp -rv doc/* $(O)/doc/termux-container/
endif
SHARE = $(O)/termux-container
$(SHARE):$(O)
ifneq ($(shell test -d $(SHARE)||echo x),)
	@cp -rv share $(O)/termux-container
endif
BIN = $(O)/bin
$(BIN):$(O)
ifneq ($(shell test -d $(BIN)||echo x),)
	@mkdir -v $(BIN)
endif
CONTAINER = $(O)/bin/container
$(CONTAINER):$(BIN)
ifneq ($(shell test -f $(CONTAINER)||echo x),)
	@cp -v src/container $(O)/bin/container
endif
ROOTFSTOOL = $(O)/bin/rootfstool
$(ROOTFSTOOL):$(BIN)
ifneq ($(shell test -f $(ROOTFSTOOL)||echo x),)
	@cp -v src/rootfstool/rootfstool $(O)/bin/rootfstool
endif
CONTAINER_CONSOLE = $(O)/bin/container-console
$(CONTAINER_CONSOLE):$(BIN)
ifneq ($(shell test -f $(CONTAINER_CONSOLE)||echo x),)
	@printf "\033[1;38;2;254;228;208m[+] Compile container-console.\033[0m\n"&&sleep 1s
	@cd src/container-console&&clang -static -ffunction-sections -fdata-sections -Wl,--gc-sections -lcap -O3 -z noexecstack -z now -fstack-protector-all -fPIE -flto container-console.c -o container-console&&strip container-console
	@mv -v src/container-console/container-console $(O)/bin/container-console
endif
src/ruri/ruri.c:
	@printf "\033[1;38;2;254;228;208m[+] Update source code.\033[0m\n"&&sleep 1s
	@git pull
	@printf "\033[1;38;2;254;228;208m[+] Update submodule.\033[0m\n"&&sleep 1s
	@git submodule update --init
RURI = $(O)/bin/ruri
$(RURI):src/ruri/ruri.c $(BIN)
ifneq ($(shell test -f $(RURI)||echo x),)
	@printf "\033[1;38;2;254;228;208m[+] Compile ruri.\033[0m\n"&&sleep 1s
	@cd src/ruri&&make static
	@mv -v src/ruri/ruri $(O)/bin/ruri
endif
build:$(DOC) $(SHARE) $(CONTAINER) $(ROOTFSTOOL) $(CONTAINER_CONSOLE) $(RURI)
update-code:src/ruri/ruri.c
install:build
	@printf "\033[1;38;2;254;228;208m[+] Install.\033[0m\n"&&sleep 1s
	@cp -v $(O)/bin/* /data/data/com.termux/files/usr/bin/
	@cp -rv $(O)/termux-container /data/data/com.termux/files/usr/share/
	@cp -rv $(O)/doc/* /data/data/com.termux/files/usr/share/doc
DEB=$(O)/deb
$(DEB):build
ifneq ($(shell test -d $(DEB)||echo x),)
	@mkdir -v $(DEB)
	@mkdir -pv $(DEB)/data/data/com.termux/files/usr
	@mkdir -pv $(DEB)/data/data/com.termux/files/usr/bin/
	@mkdir -pv $(DEB)/data/data/com.termux/files/usr/share/
	@mkdir -pv $(DEB)/data/data/com.termux/files/usr/share/doc
	@cp -v $(O)/bin/* $(DEB)/data/data/com.termux/files/usr/bin/
	@cp -rv $(O)/termux-container $(DEB)/data/data/com.termux/files/usr/share/
	@cp -rv $(O)/doc/* $(DEB)/data/data/com.termux/files/usr/share/doc
	@cp -rv dpkg-conf $(DEB)/DEBIAN
endif
pack-deb:$(DEB)
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
help :
	@echo "Makefile is not for common user, please use the released .deb files instead."
	@echo "(>_) Moe-hacker"
