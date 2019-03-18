#!/bin/bash
set -e
quadrant_re="^#[[:space:]]+(.*)$"
ring_re="^##[[:space:]]+(.*)$"
name_re="^###[[:space:]]+(.*)$"
filenames="$1"
adopt_rows=()
adopt_name="Adopt"
trial_rows=()
trial_name="Trial"
assess_rows=()
assess_name="Assess"
hold_rows=()
hold_name="Hold"
quadrant_1="Techniques"
quadrant_1_set="FALSE"
quadrant_2="Tools"
quadrant_2_set="FALSE"
quadrant_3="Platforms"
quadrant_3_set="FALSE"
quadrant_4="Languages & Frameworks"
quadrant_4_set="FALSE"

write_line () {
	name="$1"
	ring="$2"
	quadrant="$3"
	description="$4"
    row="$name,$ring,$quadrant,FALSE,$description"
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
        if [[ "$ring" == "$adopt_name" ]]; then
            adopt+=($row)
        elif [[ "$ring" == "$trial_name" ]]; then
            trial+=($row)
        elif [[ "$ring" == "$assess_name" ]]; then
            assess+=($row)
        elif [[ "$ring" == "$hold_name" ]]; then
            hold+=($row)
        else
            echo "Invalid ring '$ring'."
            exit 2
        fi
	fi
}

add_placeholder () {
    name="Placeholder"
    quadrant="$1"
    description="TBD"
    if [[ "${#adopt[@]}" == "0" ]]; then
        adopt+=("$name,$adopt_name,$quadrant,FALSE,$description")
    elif [[ "${#trial[@]}" == "0" ]]; then
        trial+=("$name,$trial_name,$quadrant,FALSE,$description")
    elif [[ "${#assess[@]}" == "0" ]]; then
        assess+=("$name,$assess_name,$quadrant,FALSE,$description")
    else
        hold+=("$name,$hold_name,$quadrant,FALSE,$description")
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
    add_placeholder "$quadrant_1"
fi

if [[ "$quadrant_2_set" != "TRUE" ]]; then
    add_placeholder "$quadrant_2"
fi

if [[ "$quadrant_3_set" != "TRUE" ]]; then
    add_placeholder "$quadrant_3"
fi

if [[ "$quadrant_4_set" != "TRUE" ]]; then
    add_placeholder "$quadrant_4"
fi

if [[ "${#adopt[@]}" == "0" ]]; then
    add_placeholder "$(unused_quadrant)"
fi

if [[ "${#trial[@]}" == "0" ]]; then
    add_placeholder "$(unused_quadrant)"
fi

if [[ "${#assess[@]}" == "0" ]]; then
    add_placeholder "$(unused_quadrant)"
fi

if [[ "${#hold[@]}" == "0" ]]; then
    add_placeholder "$(unused_quadrant)"
fi

echo "name,ring,quadrant,isNew,description"
for row in "${adopt[@]}"
do
    echo "$row"
done

for row in "${trial[@]}"
do
    echo "$row"
done

for row in "${assess[@]}"
do
    echo "$row"
done

for row in "${hold[@]}"
do
    echo "$row"
done
