#!/bin/bash
set -e
quadrant_re="^#[[:space:]]+(.*)$"
ring_re="^##[[:space:]]+(.*)$"
name_re="^###[[:space:]]+(.*)$"
filenames="$1"
quadrant_1="Techniques"
quadrant_1_set="FALSE"
quadrant_2="Tools"
quadrant_2_set="FALSE"
quadrant_3="Platforms"
quadrant_3_set="FALSE"
quadrant_4="Languages & Frameworks"
quadrant_4_set="FALSE"
ring_1="Assess"
ring_1_set="FALSE"
ring_2="Trial"
ring_2_set="FALSE"
ring_3="Adopt"
ring_3_set="FALSE"
ring_4="Hold"
ring_4_set="FALSE"


write_line () {
	name="$1"
	ring="$2"
	quadrant="$3"
	description="$4"
	if [[ "$description" != "" && "$quadrant" != "" && "$ring" != "" && "$name" != "" ]]; then
        if [[ "$quadrant" == "$quadrant_1" ]]; then
            quadrant_1_set="TRUE"
        elif [[ "$quadrant" == "$quadrant_2" ]]; then
            quadrant_2_set="TRUE"
        elif [[ "$quadrant" == "$quadrant_3" ]]; then
            quadrant_3_set="TRUE"
        elif [[ "$quadrant" == "$quadrant_4" ]]; then
            quadrant_4_set="TRUE"
        else
            echo "Invalid quadrant '$quadrant'."
            exit 2
        fi
        if [[ "$ring" == "$ring_1" ]]; then
            ring_1_set="TRUE"
        elif [[ "$ring" == "$ring_2" ]]; then
            ring_2_set="TRUE"
        elif [[ "$ring" == "$ring_3" ]]; then
            ring_3_set="TRUE"
        elif [[ "$ring" == "$ring_4" ]]; then
            ring_4_set="TRUE"
        else
            echo "Invalid ring '$ring'."
            exit 2
        fi
		echo "\"$name\",\"$ring\",\"$quadrant\",FALSE,\"$description\""
	fi
}

function unused_ring () {
    if [[ "$ring_1_set" == "FALSE" ]]; then
        echo "$ring_1"
    elif [[ "$ring_2_set" == "FALSE" ]]; then
        echo "$ring_2"
    elif [[ "$ring_3_set" == "FALSE" ]]; then
        echo "$ring_3"
    else
        echo "$ring_4"
    fi
}

unused_quadrant () {
    if [[ "$quadrant_1_set" == "FALSE" ]]; then
        echo "$quadrant_1"
    elif [[ "$quadrant_2_set" == "FALSE" ]]; then
        echo "$quadrant_2"
    elif [[ "$quadrant_3_set" == "FALSE" ]]; then
        echo "$quadrant_3"
    else
        echo "$quadrant_4"
    fi
}

if [ "$filenames" = "" ]; then
    echo "Please specify the origin filename."
    exit 2
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

if [[ "$quadrant_1_set" != "TRUE" ]]; then
    write_line "Placeholder" $(unused_ring) "$quadrant_1" "TBD"
fi

if [[ "$quadrant_2_set" != "TRUE" ]]; then
    write_line "Placeholder" $(unused_ring) "$quadrant_2" "TBD"
fi

if [[ "$quadrant_3_set" != "TRUE" ]]; then
    write_line "Placeholder" $(unused_ring) "$quadrant_3" "TBD"
fi

if [[ "$quadrant_4_set" != "TRUE" ]]; then
    write_line "Placeholder" $(unused_ring) "$quadrant_4" "TBD"
fi
