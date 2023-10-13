#!/bin/bash

# Check if there are exactly 2 command-line arguments.
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file> <number_of_records>"
    exit 1
fi

# Assign the first argument (the input file) to the 'file' variable.
file="$1"

# Assign the second argument (the number of records to display) to the 'k' variable.
k="$2"

# Check if the file exists and is readable.
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
    echo "Error: Cannot find or read the input file: $file"
    exit 1
fi

# Extract data from the input CSV file, sort it by the 6th column in descending order, and display the top 'k' records.
awk -F ',' 'NR > 1 { print $0 }' "$file" | sort -t ',' -k 6,6nr | head -n "$k" | awk -F ',' '{ printf "Country: %s, Total Vaccinations: %s, Total Cases: %s\n", $4, $5, $6 }'

# Note: This script assumes that the input CSV file has a header row and that the desired columns are present in the file.
