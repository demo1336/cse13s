#!/bin/bash

# Check the number of  arguments. There should be 2 arguments: file and k.
if [ $# -ne 2 ]; then
	echo "Invalid number of arguments"
	exit 1
fi

# Assign the first argument to the 'file' variable and the second argument to the 'k' variable.
file=$1
k=$2

# Check if the 'file' exists and is readable. If not, exit the script with an error message.
if [ ! -f $file ] || [ ! -r $file ]; then
	echo "Cannot find/read covidVaccines.csv"
	exit 1
fi

# Use 'awk' to process the CSV file, skipping the first line (header)
# Sort it based on the 6th column (the percentage of fully vaccinated) in reverse numerical order
# Take the first 'k' lines (top 'k' records), then use 'awk' to format and print the county, state, and percentage.
awk -F ',' 'NR > 1 { print $0 }' "$file" | sort -t ',' -k 6,6nr | head -n "$k" | awk -F ',' '{ printf "%s,%s,%s\n", $4, $5, $6 }'
