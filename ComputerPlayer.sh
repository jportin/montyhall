# this file incluees the functionality that an ai player neeeds, in accordance with the player api


# numDoors is defined globally at the beginning of the function. 
getNumberOfDoors() {
    echo $numDoors
}

getFirstDoorSelection() {
    echo $(( RANDOM % $1 + 1 ))
}

switchDoor() {
    local o=("y" "n")
    local si=$(( RANDOM % 2))
    s="${o[$si]}"
    echo $s
}

getNewDoor() {
    local d=("$@")
    local ndi=$(( RANDOM % ${#d[@]} ))
    echo "${d[$ndi]}"
}
