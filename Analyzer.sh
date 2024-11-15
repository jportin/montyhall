#!/usr/bin/bash

# Read in from data.txt
# We want to know what probability of winning is if you switch doors. 
source ./Library.sh

declare -A stats
declare -A keys

linesProcessed=0
firstRead=true
while IFS=" " read -ra line; do
    # declare -p line
    ((linesProcessed++))
    [[ "${#line[@]}" -ne 3 ]] && { echo "Error: Encountered line without three parameters at $linesProcessed"; break; }

    numDoors="${line[0]}"
    switched="${line[1]}"
    [[ "${line[2]}" == "true" ]] && win=true || win=false
    keys[$numDoors]=true

    if [[ $firstRead == "true" ]]; then
        stats["$numDoors-win"]=0
        stats["$numDoors-lose"]=0
        firstRead=false
    fi

    if [[ $win == "true" ]]; then
        if [[ $switched == "y" ]]; then
            ((stats["$numDoors-switch"]++))
        else
            ((stats["$numDoors-stay"]++))
        fi
    fi
done < "./data.txt"

# declare -p stats
# declare -p keys


echo "----------------------------------------" >> "$statisticsFile"
echo "$(date)" >> "$statisticsFile"
echo "----------------------------------------" >> "$statisticsFile"

for key in "${!keys[@]}"; do
    echo "$key"
done | sort -n | while IFS=$'\n' read -ra line; do
    key=$line
    switchWins="${stats[$key-switch]}"
    stayWins="${stats[$key-stay]}"
    if [[ -z $switchWins ]]; then switchWins=0; fi
    if [[ -z $stayWins ]]; then stayWins=0; fi
    total=$(( switchWins + stayWins ))
    echo "switch=$switchWins stay=$stayWins total=$total"
    # echo $(awk -v stayWins="$stayWins" -v switchWins="$switchWins" 'BEGIN {print stayWins / switchWins}')
    echo "$line" "$switchWins" "$stayWins"
    statistics $line $switchWins $stayWins
done
