echo "Welcome to the Monty Hall simulator"

echo "The Monty Hall problem simulator  presents a famous problem in bayesian statistics developed by Monty Hall. The participant is shown three doors, and told that there is a prize behind exactly one door. After selecting one door, the host reveals the contents of one door which contains nothing. The participant is then given the option to switch their guess, or keep it the same. The results of switching your answer were surprising to even the brightest mathematicians at the time. Here, we will discover them for ourselves."

echo "\n"

# Pick the winning door index and set up an array to represent it
prizeDoorIndex=$(( RANDOM % 3))
echo "Prize door index: $prizeDoorIndex"
doors=(0 0 0)
doors[$prizeDoorIndex]=1
echo "${doors[@]}"

# Have the participant select one of the three doors
echo "Select a door, either 1, 2, or 3."
read -r firstGuess
echo "You selected $firstGuess."

# Select a door that does not contain a prize
