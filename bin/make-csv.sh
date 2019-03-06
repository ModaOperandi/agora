#!/bin/bash
set -e
quadrant_re="^#[[:space:]]+(.*)$"
ring_re="^##[[:space:]]+(.*)$"
name_re="^###[[:space:]]+(.*)$"
filenames="$1"

write_line () {
	name="$1"
	ring="$2"
	quadrant="$3"
	description="$4"
	if [[ "$description" != "" && "$quadrant" != "" && "$ring" != "" && "$name" != "" ]]; then
		echo "\"$name\",\"$ring\",\"$quadrant\",FALSE,\"$description\""
	fi
}

if [ "$filenames" = "" ]; then
    echo "Please specify the origin filename."
    exit 1
fi

echo "name,ring,quadrant,isNew,description"
description=""
name=""
quadrant=""
ring=""
IFS=';' read -ra filelist <<< "$filenames"
for filename in "${filelist[@]}"; do
    while IFS= read line
    do
        if [[ $line =~ $quadrant_re ]]; then
            write_line "$name" "$ring" "$quadrant" "$description"
            ring=""
            name=""
            quadrant="${BASH_REMATCH[1]}"
        elif [[ $line =~ $ring_re ]]; then
            write_line "$name" "$ring" "$quadrant" "$description"
            name=""
            ring="${BASH_REMATCH[1]}"
        elif [[ "$line" =~ $name_re ]]; then
            write_line "$name" "$ring" "$quadrant" "$description"
            name="${BASH_REMATCH[1]}"
            description=""
        else
            if [ "$description" != "" ]; then
                description="$description<br />"
            fi
            description="$description$line"
        fi
    done < "$filename"
    write_line "$name" "$ring" "$quadrant" "$description"
done
