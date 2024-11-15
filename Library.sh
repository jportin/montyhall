dataFile="data.txt"
statisticsFile="statistics.txt"
currentDirectory=$(pwd)

logStatistics() {
    results="$@"
    for result in "${results[@]}"; do
        echo $result >> "$currentDirectory/$dataFile" 
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
    echo "$1 $2" >> "$currentDirectory/$statisticsFile"
}

cleanUp() {
    rm -f "$currentDirectory/$dataFile"
    rm -f "$currentDirectory/$statisticsFile"
}



