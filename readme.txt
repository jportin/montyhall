There are several ways to interact with these scripts. 

    1. If you just want to play the game, go ahead and execute
        `bash ./Program.sh -i`
    This will start the program in interactive mode. 

    2. If you are an unfortunate programmer and you care about debugging information, run
        `bash ./Program.sh -i -d`
    This will ruin the game, but allow you to see the various datastructures created along the way.

    3. If you want the program to log information to the data file, use the `-l` flag
        `bash ./Program.sh -i -l`
    This will save your data for later analysis. 

    4. If you want to collect a large amount of data, the functions inside the Runner script may prove useful.
    To run n experiments with d doors, use the command
        `bash ./Runner.sh n d`
    This will start n experiments with d doors from the program with the `-l` flag to save the data.
    Additionally, if you are interested in experimental data for a random number of doors (3-10), you 
    set d=0 in the command line argument. 

    5. If you want to analyze this data and determine the win percentages for switching or not switching, run
        `bash ./Analyzer.sh`


