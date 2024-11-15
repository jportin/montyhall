#!/usr/bin/bash

dataFile="data.txt"
statisticsFile="statistics.txt"
# currentDirectory="/mnt/c/Users/johnportin/Revature/Projects/p1-montyhall"

logStatistics() {
    results="$@"
    for result in "${results[@]}"; do
        echo $result >> "./$dataFile" 
    done
}

writeStatistics() {
    args="$@"

    if [[ -z $1 ]]; then
        echo "Error: requires position argument <numberOfDoors>"
        echo "Usage: writeStatistics <numberOfDoors> <winPercentage>"
        exit 1
    fi

    if [[ -z $2 ]]; then
        echo "Error: requires position argument <winPercentage>"
        echo "Usage: writeStatistics <numberOfDoors> <winPercentage>"
        exit 1
    fi
    echo "$1 $2" >> "./$statisticsFile"
}

cleanUp() {
    rm -f "./$dataFile"
    rm -f "./$statisticsFile"
}



