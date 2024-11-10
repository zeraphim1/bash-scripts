#!/bin/bash

# Stop any running wpa_supplicant instances
sudo killall -9 wpa_supplicant

# Start wpa_supplicant with the provided configuration file
sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/<file>.conf

# Obtain an IP address via DHCP
sudo dhclient wlan0

# make sure you change the <file>.conf to the one you want to use Before running this script!
