#!/bin/bash
FILE=$1

# Retrieve the response codes
codes=$(awk '{print $9}' $FILE) 
# Sort the retrieved codes
sorted_codes=$(echo "$codes" | sort) 
# Get the unique codes
unique_sorted_codes=$(echo "$sorted_codes" | uniq)
# Count these unique sorted codes
response_codes=$(echo "$unique_sorted_codes" | wc -l)

# Calculate the average size
sizes=$(awk '{gsub("-","0",$10); print $10}' $FILE)
# Loop over sizes to sum them up
sum=0
count=0
for size in $sizes
do
	sum=$(($sum + $size))
	count=$(($count + 1))
done
# Calculate the average size
average_size=$(($sum / $count))

# Print the results
echo "$average_size"
echo "$response_codes"
