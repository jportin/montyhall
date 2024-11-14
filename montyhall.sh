echo "Welcome to the Monty Hall simulator"

echo -e "The Monty Hall problem simulator  presents a famous problem in bayesian statistics developed by Monty Hall. The participant is shown three doors, and told that there is a prize behind exactly one door. After selecting one door, the host reveals the contents of one door which contains nothing. The participant is then given the option to switch their guess, or keep it the same. The results of switching your answer were surprising to even the brightest mathematicians at the time. Here, we will discover them for ourselves."

userDoor=-1

# Problem setup
# Prompt user for the number of doors to play the game with
# Must be at least 3
while true; do
    # Prompt user
    read -r -p "How many doors should we play with: " numDoors    
    # expecting a number back
    # Check if result is a digit and if that digit is at least 3
    [[ $numDoors =~ ^[0-9]+$ && $numDoors -ge 3 ]] && break || echo -e "NumDoors must be a digit greater than or equal to 3. Try again."
done

# Pick the winning door index, and create an array of doors
prizeDoorIndex=$(( RANDOM % numDoors))
prizeDoor=$(( prizeDoorIndex + 1 ))
# Do we ever really use this?
doors=()
for (( i=0; i<numDoors; i++)); do
    [[ $i == $prizeDoorIndex ]] && doors+=(1) || doors+=(0)
done
declare -p doors

echo -e "Very well, playing with $numDoors doors."
echo -e "I have randomly placed a prize behind one of the doors."
echo -n "Go ahead and pick a door from "

while true; do 
    # Display the doors to select from
    for ((i = 0; i < numDoors; i++)); do
        echo -n "$i"
        [[ $i -ne $(( numDoors - 1 )) ]] && echo -n " " || echo -n ": "
    done

    # Collect the users input
    read -r firstSelection
    [[ $firstSelection =~ ^[0-9]+$ && $firstSelection -ge 1 && $firstSelection -le $numDoors ]] && { userDoor=$firstSelection; break; } || echo "Please make a valid selection."
done


# Select one door which is not the users selection and not the winning door
# Fist, create an array holding all the remaining doors
remainingDoors=()
for ((i = 1; i <= numDoors; i++)); do
    [[ $i -ne $prizeDoor && $i -ne $firstSelection ]] && remainingDoors+=($i)
done
declare -p remainingDoors

# Pick a random index to determine the remaining door
doorToRevealIndex=$(( RANDOM % "${#remainingDoors[@]}" ))
doorToReveal="${remainingDoors[$doorToRevealIndex]}"
echo -e "Great selection. Now, what if I tell you that there is nothing behind door: $doorToReveal"

while true; do
    read -r -p "Do you want to switch your selection? (y/n) " toSwitch

    # validate user input
    [[ $toSwitch =~ ^[yn]$ ]] && break || echo "Please enter a valid input from \"y\" and \"n\""
done

if [[ $toSwitch -eq "y" ]]; then
    switchDoors=()
    for ((i = 0; i < numDoors; i++)); do
        [[ $((i + 1)) -ne $firstSelection ]] && switchDoors+=($((i + 1)))
    done

    declare -p remainingDoors

    # Check that the door to switch to is valid
    while true; do
        read -r -p "Select a door: " newDoor
        newDoorIndex=$(( newDoor - 1 ))
        [[ $newDoor =~ ^[0-9]+$ && $newDoor -ge 0 && $newDoor -le $numDoors && $newDoor -ne $firstSelection ]] && break || echo "Please make a valid selection."
    done

    userDoor=$newDoor
else
    echo "Okay, here's your results!"
fi

if [[ $newDoor -eq $prizeDoorIndex ]]; then
    echo "You won!"
else
    echo "Loser"
fi



