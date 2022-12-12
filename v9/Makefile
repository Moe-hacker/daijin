all :
	pkg install tsu coreutils p7zip tar unzip zip git wget dpkg curl nano proot axel termux-tools util-linux pv gawk hexdump clang ndk-sysroot ndk-multilib libc-client-static libcap-static
	mkdir -p build
	cd build
	mkdir -p data/data/com.termux/files
	cp ../src/usr data/data/com.termux/files/ -rv
	cp ../src/DEBIAN . -rv
	git clone htps://github.com/Moe-hacker/moe-container
	cd moe-container
	make static
	mv container ../data/data/com.termux/files/usr/bin/moe-container
	cd ..
	rm -rf moe-container
	chmod -Rv 755 DEBIAN
	dpkg -b . ../termux-container.deb
