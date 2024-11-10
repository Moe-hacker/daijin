# Developing guide:
## Tools:
[ruri](https://github.com/Moe-hacker/ruri):Lightweight, User-friendly Linux-container Implementation         
[rurima](https://github.com/Moe-hacker/rurima):Run docker & LXC images without docker or LXC program, without kernel features support, even without root privileges!      
[rootfstool](https://github.com/Moe-hacker/rootfstool):A tool to get linux container rootfs from Lxc-image mirrors      
[yoshinon](https://github.com/Moe-hacker/yoshinon):A whiptail-like dialog box written with Bubble Tea      
ruri, rurima and yoshinon are published with the MIT License, and rootfstool is Apache-2.0.      
You can use these tools to make your own container manager, it will be very easy.      
## Why ruri:
ruri is a lightweight and simple container backend.      
ruri is easy to use, you just need to `unset LD_PRELOAD` and run it.      
ruri is more secure than chroot/unshare command.      
ruri is more powerful than chroot/unshare command.       
## How to create a container manually:
### You should install daijin first.
Or you can just modify the source for your project.          
### Use rootfs tool to get the rootfs:
```
rootfstool d -m main -d alpine -v edge
```
this command will download an alpine edge rootfs.      
### Unpack the rootfs to ./test
For ruri:      
```
sudo mkdir test
sudo tar -xvf rootfs.tar.xz -C ./test
```
For proot:       
```
mkdir test
proot --link2symlink -0 tar -xvf rootfs.tar.xz -C ./test
```
### Run the fixup script in container
For ruri:      
```
cp /data/data/com.termux/files/usr/share/daijin/fixup.sh ./test/tmp/
unset LD_PRELOAD
ruri ./test /tmp/fixup.sh
```
For proot:      
You should use the proot_start.sh in src/share      
And you should make sure src/share/proc.tar.xz is unpacked to /data/data/com.termux/files/usr/share/daijin/proc/      
```
# proot_start.sh will automatically mount $TMPDIR to /tmp
cp /data/data/com.termux/files/usr/share/daijin/fixup.sh /data/data/com.termux/files/usr/tmp
./proot_start.sh -r ./test /tmp/fixup.sh
```
### Start the container:
For ruri:      
```
unset LD_PRELOAD
ruri ./test
```
For proot:      
You should use the proot_start.sh in src/share.      
And you should make sure src/share/proc.tar.xz is unpacked to /data/data/com.termux/files/usr/share/daijin/proc/      
```
./proot_start.sh -r ./test
```
Very Simple, as you can see.      

<p align="center">「Shine as you can be」</p>
