#!/bin/bash

# Prompt the user for the input file name
read -p "Enter the input file (e.g., file.kismet): " infile

# Prompt the user for the output file name with the new wording
read -p "Enter the name of the output file (e.g., newfile.kml): " outfile

# Run the kismetdb_to_kml command with the provided input and output files
kismetdb_to_kml --in "$infile" --out "$outfile"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Conversion successful! Output saved to $outfile."
else
    echo "Error during conversion. Please check the input file and try again."
fi
