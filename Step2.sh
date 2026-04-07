#!/bin/bash

# pull in all variables
source config.txt

# set timezone
ln -sf /usr/share/zoneinfo/"$timezone" /etc/localtime

# set hwclock
hwclock --systoch

# locale uncomment section and locale-gen
## uncomment locale

## gen locale
locale-gen

# hostname
echo "$hostname" >> /etc/hostname:create

# probably not actually needed but run anyways it is for the systemd initial RAM file system
mkinitcpio -P

# set root password
echo "$rootPassword" | sudo chpasswd

# create new user
useradd -m -G wheel "$userName"

# make users in wheel group a sudoer
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel

# enable system services

# boot stuff


