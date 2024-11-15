file="data.txt"

logStatistics() {

    results="$@"
    for result in "${results[@]}"; do
        each $result >> "$file" 
    done
}