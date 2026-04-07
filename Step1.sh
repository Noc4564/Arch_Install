#!/bin/bash

# pull all variables in from file here:
## Packages
source basePackages.txt
## Vars
source config.txt

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
## get vendor ID and cut string to easy to parse for what vendor is in use
cpuVendorPreprocess=$(lscpu | grep Vendor)
cpuVendor="${cpuVendorPreprocess##* }"
## determine vendor for use in pacstrap
if [[ "$cpuVendor" == "GenuineIntel" ]]; then
	echo Vendor is: "Intel"
	cpuVendor="intel-ucode"
elif [[ "$cpuVendor" == "GenuineAMD" ]]; then
	echo Vendor is: "AMD"
	cpuVendor="amd-ucode"
else
	echo Cannot determine CPU vendor!
	exit
fi

# run pacstrap (just base packages for now)
basePackages+=("$cpuVendor")
pacstrap -K /mnt "${basePackages[@]}"

# genfstab
genfstab -U /mnt >> /mnt/etc/fstab

