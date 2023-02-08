# Final Course Project
### Project Member: Alex Lo

## Description of my design 
I will be simulating a tic tac toe game onto the DES10-Lite board, using the 6 seven segments LED to display the games, and using the 2 switches and 2 buttons to control the games. The 2 players in Tic Tac Toe must make a three in a row with their corresponding symbols using the switches and the buttons to control the game. Button 1 and button two will be used by the player to control the input. They can control where they want to place with the first button, and then place it with the second button.

One of the main constraints of the DES10-Lite board is its 6 HEX display, and the game of tic tac toe requires 9 displays to show all players’ input. To circumvent this problem, I will be making use of the 3 rightmost displays that will change their display for each flipped switch. The 3 displays will display a row of the tic tac toe game. So, it can display the top row, middle row, and bottom row of the tic tac toe board and it can be controlled by the 2 switches provided. So that way, players can view all the previous inputs, but only 1 row at a time.

While implementing my code, I made a poor decision to have the display work around button #1. Because of that, the display only refreshes itself whenever the positive edge of the button occurs. Another problem I faced, is that I was not able to implement a system to check if any of the player’s input result in a 3 in a row. I could not get that to work and will break the code whenever I tried to integrate it with the rest of my implementation. Otherwise, everything else works according to the testable features proposed in my proposal.

Source:
I did not use any external code for my implementation. Although, I did search up on the internet for errors that I have encountered and it helped me diagnose what was the specific cause.
- intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/msgs/msg
s/evrfx_vdb_net_multiple_drivers.htm
- https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjec
ts/msgs/msgs/evrfx_veri_id_not_a_function.htm
- https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjec
ts/msgs/msgs/evrfx_veri_mix_block_non_block.htm
- https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjec
ts/msgs/msgs/evrfx_veri_if_condition_does_not_match_sensitivity_list_edge.htm
I did also made use of the DE10-Lite User Manual to help me configure my pinning assignment.

Link to my video: https://youtu.be/xtjNo0AHt1U
