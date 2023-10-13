#!/bin/bash
FILE=$1
K=$2
STOPWORDS='stopwords'

# Check if the stopwords file exists and is readable. If not, exit the script with an error message.
if [ ! -f $STOPWORDS ] || [ ! -r $STOPWORDS ]; then
  echo "Cannot find/read stopwords file"
  exit 1
fi

# Convert all text to lowercase
cat $FILE | tr '[:upper:]' '[:lower:]' > tmp.txt

# Replace punctuation and spaces with newline characters
tr -s '[:punct:][:space:]' '\n' < tmp.txt > tmp2.txt

# Remove the words listed in the STOPWORDS file
grep -vwf $STOPWORDS tmp2.txt > filtered.txt

# Sort the words
sort filtered.txt > sorted.txt

# Count unique occurrences
uniq -c sorted.txt > counted.txt

# Sort in reverse numerical order and then alphabetically, retain original order if same count
sort -nr -k1 -s -k2 counted.txt > final_sorted.txt

# Get the top K words
head -n $K final_sorted.txt | awk '{print $2}' > output.txt

# Print the output
cat output.txt

# Clean up temporary files
rm tmp.txt tmp2.txt filtered.txt sorted.txt counted.txt final_sorted.txt output.txt
