#!/bin/bash

# pull in all variables
source config.txt

# set timezone
ln -sf /usr/share/zoneinfo/"$timezone" /etc/localtime

# set hwclock
hwclock --systoch

# locale uncomment section and locale-gen
## uncomment locale
sed -i '/"$locale"/s/^#//' /etc/locale.gen

## gen locale
locale-gen

# hostname
echo "$hostname" >> /etc/hostname:create

# probably not actually needed but run anyways. It is for the systemd initial RAM file system
mkinitcpio -P

# set root password
echo "$rootPassword" | sudo chpasswd

# create new user and set password
useradd -m -G wheel "$userName"
echo "$userName":"$userPassword" | sudo chpasswd

# make users in wheel group a sudoer
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel

# package installs

pacman -Syu "$additionalPackages"

# ZRAM
cat <<EOF > /etc/systemd/zram-generator.conf
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
EOF

# enable system services
systemctl enable NetworkManager
systemctl enable sddm
systemctl enable bluetooth
systemctl enable systemd-zram-setup@zram0.service

# boot stuff (installing grub)
pacman -S grub efibootmgr
mkdir /boot/EFI
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

