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


