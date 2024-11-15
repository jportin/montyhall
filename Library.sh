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
    if [[ -z "$1" ]]; then
        echo "Requires one position argument, <numExperiments>"
        echo "Usage: experimentRunner <numExperiments>"
        exit 1
    fi
    numExperiments="$1"


}
