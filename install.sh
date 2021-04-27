#!/bin/bash

## Copyright 2021 by Neel Mandal. All rights reserved.

echo "Neels Arch Installation Script"

read -p 'Are you connected to internet? [y/N]: ' neton
if ! [ $neton = 'y' ] && ! [ $neton = 'Y' ]
then 
    echo "Connect to internet to continue..."
    exit
fi

echo "disks available"
lsblk

echo "select drive"
read drive 

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $drive
  g # new gpt label
  n # new partition
    # default - partition number
    # default - start at beginning of disk 
  +100M # 100 MB boot parttion
  t # type of partition
  1 # EFI system
  n # new partition
    # default-partition number
    # partion number 2
    # default, start immediately after preceding partition
  w # write the partition table
  q # and we're done
EOF

echo "formatting disks"

echo "formatting efi partition"
mkfs.fat -F32 $drive"1"

echo "formatting / partition"
mkfs.ext4 $drive"2"

echo "mounting / partition"
mount $drive"2" /mnt

echo "making /mnt/boot/efi directory"
mkdir -p /mnt/boot/efi

echo "mounting efi partition"
mount $drive"1" /mnt/boot/efi

echo "listing mounts"
lsblk

echo "running pacstrap on mnt"
pacstrap /mnt base base-devel linux linux-headers linux-firmware nano git 

echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "verifying fstab"
cat /mnt/etc/fstab

echo "copying post-chroot script"
cp -rfv post-chroot.sh /mnt/root/

echo "entering chroot"
arch-chroot /mnt

echo "installation done, You may reboot now."
