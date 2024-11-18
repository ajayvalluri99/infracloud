#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: ./gencsv.sh <start_index> <end_index>"
  exit 1
fi

# Read the start and end indices
start_index=$1
end_index=$2

# Validate that arguments are integers
if ! [[ "$start_index" =~ ^[0-9]+$ && "$end_index" =~ ^[0-9]+$ ]]; then
  echo "Error: Both arguments must be positive integers."
  exit 1
fi

# Validate that start_index is less than end_index
if [ "$start_index" -ge "$end_index" ]; then
  echo "Error: Start index must be less than end index."
  exit 1
fi

# Output file name
output_file="inputFile"

# Generate the file
> "$output_file"  # Clear the file if it exists
for (( i=start_index; i<=end_index; i++ )); do
  random_number=$(( RANDOM % 1000 ))  # Generate a random number between 0-999
  echo "$i, $random_number" >> "$output_file"
done

echo "File '$output_file' generated successfully with $(($end_index - $start_index + 1)) entries."

