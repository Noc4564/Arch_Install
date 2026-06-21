#!/bin/bash

# pull existing variables and package install info
source config.txt
source pkgs-to-install.txt

# types of package group descriptions
## core: main system packages most are nonnegotiable
## Games: various packages that either aid in running games or would likely be needed for gaming realistically such as discord and steam
## Intel GPU: drivers for intel GPUs
## Laptop: brightness and power controls
## Nvidia: Nvidia driver packages
## Packages: additional package managers or utilities
## Productivity: various apps for varying types of productive work
## Script/Code: packages for scripting and codeing
## Surface: microsoft surface packages (probably need to setup a special install process for these)
## Utility: nice utility programs probably merge into another group later
## VM: virtual machine packages
## Wine: wine...
## Wireless: litterally just bluetooth handling
## IDK: packages that still need proper sorting into a group

# Ask what package groups to install and update pkgs-to-install.txt accordingly
while read -r line <&3; do # the <&3 works in conjuction with the 3< right after the done portion of the while loop to make the read command within the loop not read from the file as well
  lineCut="${line%%=*}"
  echo "install $lineCut""?"
  read keep
  newLine="$lineCut"=\""$keep"\"
  sed -i "/"$line"/c\\$newLine" pkgs-to-install.txt
done 3< "pkgs-to-install.txt"# ask for variable changes


# verify remaining variables that ususally don't need changing


