#!/bin/bash

# Open a terminal window and display a message at the start
gnome-terminal -- bash -c "
echo 'Running script for Wi-Fi connection...';
echo '------------------------------------------';

# Prompt for network interface name
read -p 'Enter your network interface (e.g., wlan0): ' interface
echo 'You chose interface: $interface';

# Prompt for WPA configuration file
read -p 'Enter the path to your WPA configuration file: ' file
echo 'You chose WPA config file: $file';

# Kill all wpa_supplicant processes to avoid conflicts
echo 'Stopping any running wpa_supplicant processes...'
sudo killall -9 wpa_supplicant

# Start wpa_supplicant with the specified interface and WPA config file
echo 'Starting wpa_supplicant on interface $interface with config $file...'
sudo wpa_supplicant -B -i \$interface -c \$file

# Run dhclient to request an IP address
echo 'Running dhclient to obtain an IP address...'
sudo dhclient \$interface

# Wait until the interface has an IP address
echo 'Waiting for IP address on \$interface...'
timeout=30  # Timeout after 30 seconds if no IP address is acquired
count=0

while ! ip addr show \$interface | grep -q 'inet '; do
    if [ \$count -ge \$timeout ]; then
        echo 'Timeout reached. Could not obtain an IP address.'
        exit 1
    fi
    echo 'Waiting for IP address... (\$count/\$timeout)'
    sleep 2
    ((count++))
done

# Once an IP address is acquired, open a new terminal window and ping 8.8.8.8
echo 'IP address acquired. Launching terminal to ping 8.8.8.8...'
gnome-terminal -- bash -c 'ping 8.8.8.8; exec bash'

# Exit the script
exit 0
"
