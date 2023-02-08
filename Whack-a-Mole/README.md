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
