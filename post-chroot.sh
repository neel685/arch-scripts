#!/bin/bash

## Copyright 2021 by Neel Mandal. All rights reserved.

echo "Neels Arch Installation Script"

echo "changing locales"
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen

echo "generating locale"
locale-gen

echo "writing conf to locale-conf"
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "fixing timezone"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

echo "installing grub and network manager"
pacman -Syu grub efibootmgr networkmanager

echo "enabling network manager on boot"
systemctl enable NetworkManager

echo "installing grub"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=uefi_grub

echo "generating grub config"
grub-mkconfig -o /boot/grub/grub.cfg

echo "done, kindly set root password"
passwd

echo "enter username:"
read user

echo "done, adding new user to wheel group" 
useradd -mG wheel $user

echo "set password for user"
passwd $user

echo "give wheel group the permission to run sudo commands"
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers

echo "Done!, you can exit chroot now."
