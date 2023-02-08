# Whack-a-Mole Project
### By Alex Lo & Andres Tinoco



## Project Report

For this EECS 3216 Z project, we will be replicating a toy called “Bop It” as shown below. It's a toy that entails a series of mini games where you do the mini games within a time limit. Those mini games involve physically interacting with the toy in a certain way, such as twisting a knob, smacking a button or shaking the toy.

To replicate this, we will be making use of the DE10 Lite board physical features. Such that we are using the board’s buttons, and switches. We cannot fully replicate all the features that the “Bop It” toy’s features, so we made 2 mini games that the user must complete within a certain amount of time.

The game cycles between the subtraction minigame and the whack a mole mini game and counts your score. When you lose any game it displays your high score (How many times you correctly beat the games consecutively). 

KEY1 can reset the game.

When the game starts the user has 5 seconds to solve the problem. The first game is subtraction. The seven segment display shows two numbers. The user must subtract these numbers then input the answer using the switches (SW0-SW3) in binary. When the user has found the answer they input it using KEY0. If the user runs out of time they lose the game.

Example : “6-4=25” -> “6-4=24” -> “6-4=23”

The number in red in the above example is the countdown. The second game is whack a mole. This game utilizes the 10 LED’s above the switches (SW0-SW9). When the game starts one of these LEDs will turn on and the user has 5 seconds to flip the corresponding switch. The seven segment display shows:

Example: “nnole5” -> “nnole4” -> “nnole3” …

Every game won counts up to your high score until you lose! When you lose the seven segment display shows: done “highscore”

Example : “done 4”

## Math
This mini game makes use of the 4 right most switches as input. The user input will behave like a binary and output a specific decimal according to the switches. For example, if the switches are [0,0,1,1], then the user input will be “3” on the hex display. The goal of this mini game is that the users are to input the right number to a subtraction as displayed on the displays within the time limit. To be able to transition to a different state, the user must either wait for 5 seconds to get moved to the finish state, or the user must input the right number. The machine checks if the user got the right number by generating two different numbers that are to be displayed and check if the difference is the same. If the user gets the right answer, then they win this mini game and the game state will transition to the “Whack a mole” state.

## Whack a Mole
When entering the whack a mole state the switches are read and stored in the originalPositions array. This holds how the switches were as the game started. This is used to compare what the user does and compares the switches before and after they were changed. This is done by using the newPositions variable. This reads the switches as the game is counting. When this is done we can compare the newPositions with the originalPositions and store the changes in the changes variable.

The counter counts up to 50,000,000 this is for every second. Every second that passes the originalPositions are updated to make sure that even if the user has switched the incorrect switch, when the correct switch is changed the user wins the game. Therefore whacking the mole. 

After winning the game, the state exits and changes the location of the LED so the next round the mole will be on a different LED. There are 10 positions the mole can be in as the game continues the mole will switch to any of these LED’s.

