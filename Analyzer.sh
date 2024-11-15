# Read in from data.txt
# We want to know what probability of winning is if you switch doors. 

declare -A stats

linesProcessed=0
firstRead=true
while IFS=" " read -ra line; do
    declare -p line
    ((linesProcessed++))
    [[ "${#line[@]}" -ne 3 ]] && { echo "Error: Encountered line without three parameters at $linesProcessed"; break; }

    numDoors="${line[0]}"
    switched="${line[1]}"
    [[ "${line[2]}" == "true" ]] && win=true || win=false

    if [[ $firstRead == "true" ]]; then
        stats["$numDoors-win"]=0
        stats["$numDoors-lose"]=0
        firstRead=false
    fi

    [[ $win == "true" ]] && ((stats["$numDoors-win"]++)) || ((stats["$numDoors-lose"]++))
done < "./data.txt"

declare -p stats