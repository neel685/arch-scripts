# My personal Arch install scripts
these are some scripts i use personally to automate my arch linux installation, this script creates a 100MB efi partition and gives the remainder to the / (root) partition.
it installs very minimal packages on the installation to keep the installation very simple. 

# Packages installed are :
- base
- base-devel
- linux 
- linux-headers
- linux-firmware
- nano
- git
- grub
- efibootmgr
- networkmanager

# How to use ?
usage is very simple, get yourself connected to the internet, wifi users can use `iwctl`. Then, simply curl the scripts and execute, instructions to do so are given below.
```
curl https://downloads.neel685.workers.dev/2:/install.sh > install.sh
curl https://downloads.neel685.workers.dev/2:/post-chroot.sh > post-chroot.sh
bash install.sh
```

after entering chroot, u can simply run the post chroot script by:

```
bash root/post-chroot.sh
```
and your installation will be done, you can then reboot and install your favourite Desktop Environments.

# **Notes:** 
- this is only for EFI systems. MBR users can use <a href="https://www.youtube.com/watch?v=QtBDL8EiNZo">this guide.</a>
- i am not installing any intel/amd ucodes, or gpu utils as everybody has different specifications and this script would render useless if it was targetted to specific configurations. therefore, feel free to fork and edit the script to install your laptop/desktop specific ucodes/gpu utils.
- Contributions are always welcome. Just fork and PR
