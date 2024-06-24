#!/bin/bash

filename=$1
results_file="website_status.log"

# Check if the results file exists and remove it
if [ -f "$results_file" ]; then
    echo "Removing the existing results file"
    rm "$results_file"
fi

if [ ! -f "$filename" ]; then
    url_list=("https://www.google.com" "https://www.facebook.com")
else
    readarray -t url_list < "$filename"
fi

# Print the URLs and check their status
for url in "${url_list[@]}"; do
    res=$(curl --request GET -sL --url "$url" -w "%{http_code}" -o /dev/null)
    if [ "$res" -eq 200 ]; then
        echo "<$url> is UP" >> "$results_file"
    else
        echo "<$url> is DOWN" >> "$results_file"
    fi
done

echo "Results are saved in $results_file"