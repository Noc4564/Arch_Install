#!/bin/bash

# check bootmode

# set time via timedatectl
timedatectl

# check CPU architecture and prepare for adding required microcode to pacstrap command

# run pacstrap (just base packages for now)

# genfstab
genfstab -U /mnt >> /mnt/etc/fstab
