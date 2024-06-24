#!/bin/bash

filename=$1
results_file="website_status.log"

# Check if the results file exists and remove it
if [ -f "$results_file" ]; then
    echo "Removing the existing results file"
    rm "$results_file"
fi

if [ ! -f "$filename" ]; then
    echo "No input file was specified."
    echo "Reading the URLs from the script"
    url_list=("https://www.google.com" "https://www.facebook.com")
else
    echo "Reading the URLs from the file $filename"
    readarray -t url_list < "$filename"
fi

# Print the URLs and check their status
for url in "${url_list[@]}"; do

    final_url=$(curl -s -L -o /dev/null -w "%{url_effective}" "$url")
    if [ "$final_url" != "" ]; then
        res=$(curl -s -L -o /dev/null -w "%{http_code}" "$url")
    else
        res=$(curl -s -o /dev/null -w "%{http_code}" "$final_url")
    fi
    if [ "$res" -eq 200 ]; then
        echo "<$url> is UP" >> "$results_file"
    else
        echo "<$url> is DOWN" >> "$results_file"
    fi
done

echo "Results are saved in $results_file"
