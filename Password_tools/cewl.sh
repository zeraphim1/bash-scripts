#!/bin/bash

# Prompt for output file
read -p "Enter the output file for wordlist: " outputfile

# Prompt for depth level, default to 1 if not given
read -p "Enter the depth (integer, e.g., 2, default is 1): " depth
depth=${depth:-1}  # Default to 1 if no input is given

# Prompt for minimum word length, default to 3 if not given
read -p "Enter the minimum number of characters for words (integer, e.g., 4, default is 3): " min_chars
min_chars=${min_chars:-3}  # Default to 3 if no input is given

# Prompt for maximum word length, do not add flag if not given
read -p "Enter the maximum number of characters for words (integer, e.g., 10, leave blank for no limit): " max_chars

# Prompt for including emails
read -p "Do you want to include email addresses? (y/n): " include_emails
if [[ "$include_emails" == "y" || "$include_emails" == "Y" ]]; then
    email_flag="-e"
else
    email_flag=""
fi

# Prompt for including numbers in the wordlist
read -p "Do you want to include numbers in the wordlist? (y/n): " include_numbers
if [[ "$include_numbers" == "y" || "$include_numbers" == "Y" ]]; then
    numbers_flag="--with-numbers"
else
    numbers_flag=""
fi

# Prompt for the website URL
read -p "Enter the website URL (e.g., https://example.com): " website

# Construct the cewl command
command="cewl -w $outputfile -d $depth -m $min_chars $email_flag $numbers_flag $website"

# Add the -x flag if a maximum word length is provided
if [[ -n "$max_chars" ]]; then
    command="$command -x $max_chars"
fi

# Display the constructed cewl command
echo "Running command: $command"

# Run the cewl command with the provided arguments
eval $command
