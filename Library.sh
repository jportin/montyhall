file="data.txt"

logStatistics() {
    results="$@"
    for result in "${results[@]}"; do
        echo $result >> "$file" 
    done
}

cleanUp() {
    rm -f "data.txt"
}

experimentRunner() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "Requires two positional argumenst, <numExperiments> and <numDoors>"
        echo "Usage: experimentRunner <numExperiments> <numDoors>"
        exit 1
    fi


    numExperiments="$1"
    numDoors="$2"

    for ((i=0; i<$numExperiments; i++)); do
        ./Program.sh "-l" "$numDoors"
    done
}
