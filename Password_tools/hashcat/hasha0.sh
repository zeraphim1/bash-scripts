#!/bin/bash

# Prompt for input hash type
read -p "Enter the input hash type (e.g., 0 for MD5, 100 for SHA1): " INPUTHASH

# Check if the user wants to use the --username option
read -p "Do you want to use the --username option? (yes/no): " USE_USERNAME

# Prompt for hash file and wordlist based on the previous input
if [[ "$USE_USERNAME" == "yes" ]]; then
    read -p "Enter the path to the file containing hashes (with usernames): " HASHFILE
else
    read -p "Enter the path to the file containing hashes: " HASHFILE
fi

read -p "Enter the path to the wordlists (e.g., /path/to/wordlist.txt): " WORDLISTS

# Construct the Hashcat command
if [[ "$USE_USERNAME" == "yes" ]]; then
    COMMAND="hashcat -a0 -m$INPUTHASH -D1,2 -O --force --username $HASHFILE $WORDLISTS"
else
    COMMAND="hashcat -a0 -m$INPUTHASH -D1,2 -O --force $HASHFILE $WORDLISTS"
fi

# Print the command syntax
echo "The command will be:"
echo "$COMMAND"

# Confirm before running
read -p "Does this look correct? (yes/no): " CONFIRM

if [[ "$CONFIRM" == "yes" ]]; then
    # Run Hashcat command
    echo "Running Hashcat..."
    eval $COMMAND
else
    echo "Operation canceled."
fi

# End of script

