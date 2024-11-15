source "./Library.sh"

runExperiment() {
    if [[ -z "$1" ]]; then
        echo "Requires <numDoors> as a position argument."
        echo "Usage: experimentRunner <numExperiments> <numDoors>"
        exit 1
    fi

    if [[ -z "$2" ]]; then
        echo "Requires <numExperiments> as a position argument."
        echo "Usage: experimentRunner <numExperiments> <numDoors>"
        exit 1
    fi


    numDoors="$1"
    numExperiments="$2"

    for ((i=0; i<$numExperiments; i++)); do
        ./Program.sh "-l" "$numDoors"
    done
}

runExperiment $1 $2
./Analyzer.sh

# runExperiment 3 1000