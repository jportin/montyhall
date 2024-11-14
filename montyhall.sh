echo "Welcome to the Monty Hall simulator"

echo -e "The Monty Hall problem simulator  presents a famous problem in bayesian statistics developed by Monty Hall. The participant is shown three doors, and told that there is a prize behind exactly one door. After selecting one door, the host reveals the contents of one door which contains nothing. The participant is then given the option to switch their guess, or keep it the same. The results of switching your answer were surprising to even the brightest mathematicians at the time. Here, we will discover them for ourselves."

# Problem setup
# Prompt user for the number of doors to play the game with
# Must be at least 3
while true; do
    # Prompt user
    read -r -p "How many doors should we play with: " numDoors    
    # expecting a number back
    # Check if result is a digit and if that digit is at least 3
    [[ $numDoors =~ ^[0-9]+$ && $numDoors -ge 3 ]] && break || { echo -e "NumDoors must be a digit greater than or equal to 3. Try again."; continue; }
done

# Pick the winning door, and create an array of doors
prizeDoorIndex=$(( RANDOM % numDoors))
echo "Prize door index: $prizeDoorIndex"
doors=()
for (( i=0; i<numDoors; i++)); do
    [[ $i == $prizeDoorIndex ]] && doors+=(1) || doors+=(0)
done

# To test and make sure this is initialized correctly, check
declare -p doors

echo -e "Very well, playing with $numDoors doors."
echo -e "I have randomly placed a prize behind one of the doors."
echo -e "Go ahead and pick a door."

# Pick the winning door index and set up an array to represent it



# Have the participant select one of the three doors
echo "Select a door, either 1, 2, or 3."
# read -r firstGuess
# echo "You selected $firstGuess."

# Select a door that does not contain a prize
