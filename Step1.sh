#!/bin/bash

# pull all variables in from file here:
## Packages

## Other vars


# check bootmode
bootmode=$(cat /sys/firmware/efi/fw_platform_size)
if [[$bootmode != 64 ]]; then
	echo Bootmode does not equal 64 exiting script.
	exit
else
	echo Bootmode check passed!
fi

# set time via timedatectl
timedatectl


## potentialy add in mirror sorting here for faster install!!!!


# check CPU architecture and prepare for adding required microcode to pacstrap command


# run pacstrap (just base packages for now)
pacstrap -K /mnt $basePackages

# genfstab
genfstab -U /mnt >> /mnt/etc/fstab
