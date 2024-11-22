# This file includes the functionality that a typical player would need, in accordance with the player api

getNumberOfDoors() {
    local numDoors=-1
    read -r numDoors
    echo $numDoors
}

getFirstDoorSelection() {
    read -r firstSelection
    echo $firstSelection
}

switchDoor() {
    read -r s
    echo $s
}

getNewDoor() {
    local n
    read -r n
    echo "$n"
}