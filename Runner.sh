#!/usr/bin/bash

source "./Library.sh"

runExperiment() {
    if [[ -z "$1" ]]; then
        echo "Requires <numDoors> as a position argument."
        echo "Usage: experimentRunner <numDoors> <numExperiments>"
        exit 1
    elif [[ "$1" -eq 0 ]]; then
        numDoors=$((RANDOM % 8 + 3))
    else
        numDoors="$1"
    fi

    if [[ -z "$2" ]]; then
        echo "Requires <numExperiments> as a position argument."
        echo "Usage: experimentRunner <numExperiments> <numDoors>"
        exit 1
    fi

    numExperiments="$2"

    for ((i=0; i<$numExperiments; i++)); do
        ./Program.sh "-l" "$numDoors"
    done
}

runExperiment $1 $2
./Analyzer.sh