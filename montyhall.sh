#!/usr/bin/bash

echo "-----------------------------------------"
echo "|  Welcome to the Monty Hall simulator  |"
echo "-----------------------------------------"

echo -e "This simulator presents a famous problem in bayesian statistics developed by Monty Hall."
echo "-----------------------------------------"
echo -e "Three doors will be presented to you. Behind one door is a prize, and behind the other two doors is nothing."
echo -e "You will begin by guessing which of the doors you think has the prize."
echo -e "After youur first guess, the host will reveal one of the doors that has nothing."
echo -e "Then, you will be given the option to switch doors."
echo -e "Finally, it will be revealed if you guessed right and won the prize, or not."

# This should probably just be logged, not output to std out. 
interactive=false
debug=false
log=false
numDoors=-1
while getopts "idl:" opt; do
    case $opt in
        i)
            echo "Running in interactive mode."
            interactive=true
            ;;
        d)
            echo "Running in debug mode. This will ruin the gaming experience."
            debug=true
            ;;
        l)
            echo "Running in logging mode."
            log=true
    esac
done

shift $((OPTIND - 1))
if [[ $interactive == "false" ]]; then
    if [[ -z "$1" ]]; then 
        echo "ERROR: <numdoors> is a required position argument"
        echo "Usage: $0 [-i] [-d] <numDoors>"
        exit 1
    else
        numDoors="$1"
        [[ $debug == "true" ]] && echo -e "CONFIRM: numDoors = $numDoors"
    fi
fi

userDoor=-1

# Problem setup
# Prompt user for the number of doors to play the game with
# Must be at least 3
while true; do
    # Prompt user
    [[ $interactive == "true" ]] && read -r -p "How many doors should we play with: " numDoors    
    # expecting a number back
    # Check if result is a digit and if that digit is at least 3
    [[ $numDoors =~ ^[0-9]+$ && $numDoors -ge 3 ]] && break || echo -e "NumDoors must be a digit greater than or equal to 3. Try again."
done

# Pick the winning door index, and create an array of doors
prizeDoorIndex=$(( RANDOM % numDoors))
prizeDoor=$(( prizeDoorIndex + 1 ))
$debug && echo -e "The winning door is..... $prizeDoor!!!!!"
# Do we ever really use this?
# doors=()
# for (( i=0; i<numDoors; i++)); do
#     [[ $i == $prizeDoorIndex ]] && doors+=(1) || doors+=(0)
# done
# $debug && declare -p doors

if [[ $interactive == "true" ]]; then
    echo -e "Very well, playing with $numDoors doors."
    echo -e "I have randomly placed a prize behind one of the doors."
    echo -n "Go ahead and pick a door from "
fi

while true; do 
    # Display the doors to select from
    for ((i = 1; i <= numDoors; i++)); do
        echo -n $i
        [[ $i -ne $numDoors ]] && echo -n " " || echo -n ": "
    done
    if [[ $interactive == "true" ]]; then
        read -r firstSelection
    else 
        firstSelection=$(( RANDOM % numDoors + 1))
    fi
        [[ $debug == "true" ]] && echo -e "CONFIRMING: first selection = $firstSelection"
        [[ $firstSelection =~ ^[0-9]+$ && $firstSelection -ge 1 && $firstSelection -le $numDoors ]] && { userDoor=$firstSelection; break; } || echo "Please make a valid selection."
done


# Select one door which is not the users selection and not the winning door
# Fist, create an array holding all the remaining doors
remainingDoors=()
for ((i = 1; i <= numDoors; i++)); do
    [[ $i -ne $prizeDoor && $i -ne $firstSelection ]] && remainingDoors+=($i)
done
[[ $debug == "true" ]] && declare -p remainingDoors

# Pick a random index to determine the empty door to reveal
doorToRevealIndex=$(( RANDOM % "${#remainingDoors[@]}" ))
doorToReveal="${remainingDoors[$doorToRevealIndex]}"

[[ $interactive == "true" || $debug == "true" ]] && echo -e "Great selection. Now, what if I tell you that there is nothing behind door: $doorToReveal"

while true; do
    if [[ $interactive == true ]]; then
        read -r -p "Do you want to switch your selection? (y/n) " toSwitch
    else
        options=("y" "n")
        toSwitchIndex=$(( RANDOM % 2))
        toSwitch="${options[$toSwitchIndex]}"
    fi
    [[ $debug == "true" ]] && echo -e "CONFIRMING: toSwitch = $toSwitch"
    [[ $toSwitch =~ ^[yn]$ ]] && break || echo "Please enter a valid input from \"y\" and \"n\""
done

if [[ $toSwitch == "y" ]]; then
    [[ $interactive == "true" ]] && echo -n "Switching doors. Select from: "
    switchDoors=()
    for ((i = 1; i <= numDoors; i++)); do
        [[ $i -ne $firstSelection && $i -ne $doorToReveal ]] && switchDoors+=($i)
    done

    if [[ $interactive == "true" ]]; then
        for i in "${switchDoors[@]}"; do
            echo -n "$i "
        done
    fi

    [[ $debug == "true" ]] && declare -p switchDoors

    # Check that the door to switch to is valid
    while true; do
    if [[ $interactive == "true" ]]; then
            read -r -p "Select a door: " newDoor
        else
            newDoorIndex=$(( RANDOM % ${#switchDoors[@]} ))
            newDoor="${switchDoors[$newDoorIndex]}"
        fi
        [[ $debug == "true" ]] && echo -e "CONFIRM: Switching door to $newDoor."
        [[ $newDoor =~ ^[0-9]+$ && $newDoor -ge 1 && $newDoor -le $numDoors && $newDoor -ne $firstSelection && $newDoor -ne $doorToReveal ]] && break || echo "Please make a valid selection."
    done

    userDoor=$newDoor
else
    [[ $debug == "true" ]] && echo "Okay, here's your results!"
fi

[[ $userDoor -eq $prizeDoor ]] && userWin=true || userWin=false

if [[ $userWin == "true" ]]; then
    echo "You won!"
else
    echo "Loser"
fi

# The important statistics to collect are:
# Number of doors - numDoors
# Whether the participant switched - toSwitch from "y", "n"
# Whether the participant won - userWin from "true" and "false"