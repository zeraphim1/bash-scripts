#!/bin/bash

# Prompt the user for the SSID (Wi-Fi network name)
read -p "Enter the SSID (Wi-Fi network name): " ssid

# Prompt the user for the password
read -sp "Enter the password: " password
echo  # To add a newline after the password input

# Prompt the user for the output .conf file name (without .conf)
read -p "Enter the name of the config file (without .conf , will be added): " file

# Append .conf to the user-provided file name
file="${file}.conf"

# Run the wpa_passphrase command with the provided SSID, password, and file path
sudo sh -c "wpa_passphrase \"$ssid\" \"$password\" >> /etc/wpa_supplicant/$file"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "WPA passphrase successfully added to /etc/wpa_supplicant/$file."
else
    echo "Error occurred while adding the passphrase. Please check the SSID, password, and file path."
fi
