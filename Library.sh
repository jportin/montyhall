#!/usr/bin/bash

dataFile="data.txt"
statisticsFile="statistics.txt"
# currentDirectory="/mnt/c/Users/johnportin/Revature/Projects/p1-montyhall"

logStatistics() {
    results=("$@")
    for result in "${results[@]}"; do
        echo "$@" >> "./$dataFile" 
    done
}

statistics() {
    if [[ $# -ne 3 ]]; then
        echo "Usage: statistics <numberOfDoors> <switchPercentage> <stayPercentage>"
        echo "Incorrect number of positional arguments"
        exit 1
    fi

    numDoors=$1
    switchWins=$2
    stayWins=$3

    total=$(( switchWins + stayWins ))

    if [[ $switchWins -eq 0 ]]; then
        switchPercentage="-1"
    else
        switchPercentage=$(awk -v switchWins="$switchWins" -v total="$total" 'BEGIN {print switchWins / total}')
    fi

    if [[ $stayWins -eq 0 ]]; then
        stayPercentage="-1"
    else
        stayPercentage=$(awk -v stayWins="$stayWins" -v total="$total" 'BEGIN {print stayWins / total}')
    fi

    echo "$numDoors" "$switchPercentage" "$stayPercentage" >> ./$statisticsFile
}

cleanUp() {
    rm -f "./$dataFile" "./$statisticsFile"
}



