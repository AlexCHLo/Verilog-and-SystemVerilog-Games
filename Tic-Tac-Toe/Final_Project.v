// ALEX LO
// 215681364
// TIC TAC TOE THINGY DUDE
// REEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

module Final_Project (rightSwitch, middleSwitch, leftSwitch, button_1, button_2, resetSwitch, HEX_0, HEX_1, HEX_2, HEX_3, HEX_4, HEX_5, clk);

///////////////////////////////
// INPUT
input rightSwitch;
input middleSwitch;
input leftSwitch;
input button_1; // moving selection
input button_2; // setting your selection

// last minute addition because I couldn't for the love of god to get the damn hold two buttons at the same tiem to work. 
input resetSwitch;

// OUTPUT DISPLAY!
output [7:0] HEX_0; 
output [7:0] HEX_1;
output [7:0] HEX_2;
output [7:0] HEX_3;
output [7:0] HEX_4;
output [7:0] HEX_5;

// Tic Toc Clock B)
input clk;

////////////////////////////

// variables!

// Who's Turn is it?
// parameter
// If turn = 1'b0, then consider O
// If turn = 1'b1, then consider X
reg [2:0] turn = 2'b00;
reg [10:0] turnMod;

// selection
// parameter
// if 2'b00 --> be left most
// if 2'b01 --> be middle most
// if 2'b10 --> be right most
reg [2:0] selection;
reg [10:0] selectionMod;

// Channel!
reg [2:0] channelNumber;

// player win
// 2'b00 --> no one win yet
// 2'b01 --> O win
// 2'b10 --> X win

reg [2:0] win_condition_reg = 2'b00;

// testing
reg [7:0] test = 8'b11111111; 


// display value rrepresentation
// copies value of the left, middle, and right value of a specific channel according to the switch
// used for encoding purpose

reg [2:0] HEX_0_value = 2'b11;
reg [2:0] HEX_1_value = 2'b11;
reg [2:0] HEX_2_value = 2'b11;

////////////////////////////////////

// paramter
// if playerSymbol = 2'b00, then return 0
// if playerSymol = 2'b01, then return X
// if playerSymbol = 2'b10, then return Unders
// if playerSymbol = 2'b11, then return " "

// kept it as 9 different variables because doing it in 8 bits would be kind of confusing.
// First Channel
reg [2:0] top_left = 2'b11;
reg [2:0] top_middle = 2'b11;
reg [2:0] top_right = 2'b11;

// Second Channel
reg [2:0] middle_left = 2'b11;
reg [2:0] middle_middle = 2'b11;
reg [2:0] middle_right = 2'b11;

// Third Channel
reg [2:0] bottom_left = 2'b11;
reg [2:0] bottom_middle = 2'b11;
reg [2:0] bottom_right = 2'b11;

///////////////////////////

// Checking for winner

//always @(top_left, top_middle,top_right,middle_left,middle_middle,middle_right,bottom_left,bottom_middle,bottom_right) begin
//
//
//	// Since there are 9 different possible ways
//	// i realize that if I do the k-map, I need to do 512 cells and that's kind of painful tbh. lets brute force it for now
//	// im sorry that I couldn't think up a clever method that would let me reduce this chunky number of line codes.
//
//	// checking for O winning. pretty scuffed, but it is what it is.
//
//	// horizontal for O
//	if (top_left == 2'b00 && top_middle == 2'b00 && top_right == 2'b00) begin
//	
//		win_condition_reg = 2'b01;
//
//	end 
////	else if (middle_left == 2'b00 && middle_middle == 2'b00 && middle_right == 2'b00) begin
//	
//		win_condition_reg = 2'b01;
//
//	end else if (bottom_left == 2'b00 && bottom_middle == 2'b00 && bottom_right == 2'b00) begin
//	
////		win_condition_reg = 2'b01;
////
//	end else
//
//	// vertical for O
//	if (top_left == 2'b00 && middle_left == 2'b00 &&  bottom_left == 2'b00) begin
//	
//		win_condition_reg = 2'b01;
//
//	end else if (top_middle == 2'b00 && middle_middle == 2'b00 &&  bottom_middle == 2'b00) begin
//	
//		win_condition_reg = 2'b01;
//
//	end else if (top_right == 2'b00 && middle_right  == 2'b00 &&  bottom_right == 2'b00) begin
//	
//		win_condition_reg = 2'b01;
//
//	end else
//
//	// diagionally for 0
//	if (top_left == 2'b00 && middle_middle == 2'b00 &&  bottom_right == 2'b00) begin
//
//		win_condition_reg = 2'b01;
//
//	end else if (top_right == 2'b00 && middle_middle == 2'b00 &&  bottom_right == 2'b00) begin
//	
//		win_condition_reg = 2'b01;
//
//	end 
//	
//	else
////
////	////////////////////////////////////////////////////////////////////////////////////////////
////
//	// horizontal for X
//	if (top_left == 2'b01 && top_middle == 2'b01 && top_right == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//
//	end else if (middle_left == 2'b01 && middle_middle == 2'b01 && middle_right == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//
//	end else if (bottom_left == 2'b01 && bottom_middle == 2'b01 && bottom_right == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//
//	end else
//
//	// vertical for X
//	if (top_left == 2'b01 && middle_left == 2'b01 &&  bottom_left == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//	
//	end else if (top_middle == 2'b01 && middle_middle == 2'b01 &&  bottom_middle == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//
//	end else if (top_right == 2'b01 && middle_right  == 2'b01 &&  bottom_right == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//
//	end else
//
//	// diagionally for X
//	if (top_left == 2'b01 && middle_middle == 2'b01 &&  bottom_right == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//
//	end else if (top_right == 2'b01 && middle_middle == 2'b01 &&  bottom_right == 2'b01) begin
//	
//		win_condition_reg = 2'b10;
//	
//	end 
//	
//end 

//////////////////////////

// change channel if either right, middle, and left is positive, but if and only either.
always @(rightSwitch, middleSwitch, leftSwitch) begin
// if rSw = 0, mSw = 0, lSw = 0, then display "error"
	if (rightSwitch == 0 && middleSwitch == 0 && leftSwitch == 0) begin	
		channelNumber <= 2'b00;
	end 
	else// if rSw = 1, mSw = 0, lSw = 0, then display "channel 2"
	if (rightSwitch == 1 && middleSwitch == 0 && leftSwitch == 0) begin 
		channelNumber = 2'b01;
	end
	else // if rSw = 0, mSw = 1, lSw = 0, then display "channel 3"
	if (rightSwitch == 0 && middleSwitch == 1 && leftSwitch == 0) begin
		channelNumber = 2'b10;
	end
end


/*
parameter

mayb I dont need a selection value

when button 1 is pressed
increment the selection 0 1 2 then 0 (...)

1) look at the channel. Eg. If it channel 1, then check top_left, top_middle, and top_right
2) After checking, find the available spot. Could have three scenarios
	if an available spot is found, then have our cursur there
	if no available spot is found, then display value top_left, top_middle, and top_right. Because there is no spot to place our cursor
	if all spots are available, default cursor to whatever the selection value is at

*/

always @(posedge button_1) begin
//	

	// selectionMod <= selectionMod + 1'b1;
	//selection = selectionMod % 3'b011;
	
	if (selection <= 2'b01) begin
	
		selection = selection + 1'b1;
		
	end else begin
	
		selection = 2'b00;
		
	end
	
	if (resetSwitch == 1'b1) begin // purely for demostrating what it would look like if someone win
	
		test = 8'b00000011;
		
			HEX_0_value =  3'b110;
			HEX_1_value = 3'b101;
			HEX_2_value =  3'b100;

	
	end else
	
	if (rightSwitch == 0 && middleSwitch == 0 && leftSwitch == 0) begin
	
			test = 8'b11111111;
		// 
		
		case (selection)
			
			2'b00: begin
				
				if (top_right == 2'b11) begin
					
					HEX_0_value =  2'b10;
					HEX_1_value = top_middle;
					HEX_2_value =  top_left;
					
					selection = 2'b00;
				
				end else if (top_middle == 2'b11) begin
				
					HEX_0_value = top_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  top_left;
					
			
					selection = 2'b01;
				
				end else if (top_left == 2'b11) begin
				
					HEX_0_value = top_right;
					HEX_1_value = top_middle;
					HEX_2_value <=   2'b10;
					

					selection = 2'b10;
				
				end else begin 
				
				HEX_0_value = top_right;
				HEX_1_value = top_middle;
				HEX_2_value =  top_left;
				
				end
				
			end
				
			2'b01: begin
				
				if (top_middle == 2'b11) begin
				
					HEX_0_value = top_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  top_left;
					
					selection =  2'b01;
					
				end else if (top_left == 2'b11) begin
				
					HEX_0_value = top_right;
					HEX_1_value = top_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else if (top_right == 2'b11) begin
				
					HEX_0_value <=  2'b10;
					HEX_1_value = top_middle;
					HEX_2_value =  top_left;
					
					selection =  2'b00;
				
				end else begin 
				
				HEX_0_value = top_right;
				HEX_1_value = top_middle;
				HEX_2_value =  top_left;
				
				end
				
			end
				
			2'b10: begin
				
				if (top_left == 2'b11) begin
					
					HEX_0_value = top_right;
					HEX_1_value = top_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else if (top_right == 2'b11) begin
				
					HEX_0_value =  2'b10;
					HEX_1_value = top_middle;
					HEX_2_value =  top_left;
					
					selection =  2'b00;
					
					
				end else if (top_middle == 2'b11) begin
				
					HEX_0_value = top_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  top_left;
					
					selection =  2'b01;
				
				end else begin 
				
				HEX_0_value = top_right;
				HEX_1_value = top_middle;
				HEX_2_value =  top_left;
				
				end
				
			end
				
		endcase
		
	end else if (rightSwitch == 1 && middleSwitch == 0 && leftSwitch == 0) begin
	
			case (selection)
			
			2'b00: begin
				
				if (middle_right == 2'b11) begin
					
					HEX_0_value =  2'b10;
					HEX_1_value = middle_middle;
					HEX_2_value =  middle_left;
					
					selection =  2'b00;
				
				end else if (middle_middle == 2'b11) begin
				
					HEX_0_value = middle_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  middle_left;
					
					selection =  2'b01;
				
				end else if (top_left == 2'b11) begin
				
					HEX_0_value = middle_right;
					HEX_1_value = middle_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else begin 
				
				HEX_0_value = middle_right;
				HEX_1_value = middle_middle;
				HEX_2_value =  middle_left;
				
				end
				
			end
				
			2'b01: begin
				
				if (middle_middle == 2'b11) begin
				
					HEX_0_value = middle_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  middle_left;
					
					selection =  2'b01;
					
				end else if (middle_left == 2'b11) begin
				
					HEX_0_value = middle_right;
					HEX_1_value = middle_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else if (middle_right == 2'b11) begin
				
					HEX_0_value <=  2'b10;
					HEX_1_value = top_middle;
					HEX_2_value =  top_left;
					
					selection =  2'b00;
				
				end else begin 
				
				HEX_0_value = middle_right;
				HEX_1_value = middle_middle;
				HEX_2_value =  middle_left;
				
				end
				
			end
				
			2'b10: begin
				
				if (middle_left == 2'b11) begin
					
					HEX_0_value = middle_right;
					HEX_1_value = middle_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else if (middle_right == 2'b11) begin
				
					HEX_0_value =  2'b10;
					HEX_1_value = middle_middle;
					HEX_2_value =  middle_left;
					
					selection =  2'b00;
					
					
				end else if (top_middle == 2'b11) begin
				
					HEX_0_value = middle_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  middle_left;
					
					selection =  2'b01;
				
				end else begin 
				
				HEX_0_value = middle_right;
				HEX_1_value = middle_middle;
				HEX_2_value =  middle_left;
				
				end
				
			end
				
		endcase
		
	end else if (rightSwitch == 0 && middleSwitch == 1 && leftSwitch == 0) begin
	
			case (selection)
			
			2'b00: begin
				
				if (bottom_right == 2'b11) begin
					
					HEX_0_value =  2'b10;
					HEX_1_value = bottom_middle;
					HEX_2_value =  bottom_left;
					
					selection =  2'b00;
				
				end else if (bottom_middle == 2'b11) begin
				
					HEX_0_value = bottom_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  bottom_left;
					
					selection = 2'b01;
				
				end else if (bottom_left == 2'b11) begin
				
					HEX_0_value = bottom_right;
					HEX_1_value = bottom_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else begin 
				
				HEX_0_value = bottom_right;
				HEX_1_value = bottom_middle;
				HEX_2_value = bottom_left;
				
				end
				
			end
				
			2'b01: begin
				
				if (bottom_middle == 2'b11) begin
				
					HEX_0_value = bottom_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  bottom_left;
					
					selection =  2'b01;
					
				end else if (bottom_left == 2'b11) begin
				
					HEX_0_value = bottom_right;
					HEX_1_value = bottom_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else if (bottom_right == 2'b11) begin
				
					HEX_0_value <=  2'b10;
					HEX_1_value = bottom_middle;
					HEX_2_value = bottom_left;
					
					selection =  2'b00;
				
				end else begin 
				
				HEX_0_value = bottom_right;
				HEX_1_value = bottom_middle;
				HEX_2_value =  bottom_left;
				
				end
				
			end
				
			2'b10: begin
				
				if (bottom_left == 2'b11) begin
					
					HEX_0_value = bottom_right;
					HEX_1_value = bottom_middle;
					HEX_2_value =  2'b10;
					
					selection =  2'b10;
				
				end else if (bottom_right == 2'b11) begin
				
					HEX_0_value =  2'b10;
					HEX_1_value = bottom_middle;
					HEX_2_value =  bottom_left;
					
					selection =  2'b00;
					
				end else if (bottom_middle == 2'b11) begin
				
					HEX_0_value = bottom_right;
					HEX_1_value = 2'b10;
					HEX_2_value =  bottom_left;
					
					selection =  2'b01;
				
				end else begin 
				
				HEX_0_value = bottom_right;
				HEX_1_value = bottom_middle;
				HEX_2_value =  bottom_left;
				
				end
				
			end
				
		endcase
	
	end 
	
end

/*

when button 2 is pressed

"place" an X or O depending on the value of our turn

before placing, we need to check two things

check what is our channel number
	then...
		check what is our selection number
		
	then...
		place it
		and increment turnMod / turn line
*/

always @(posedge button_2) begin

	// checking for which channel are we at
	
	if (button_1 == 1'b0) begin
		top_left = 2'b11;
		top_middle = 2'b11;
		top_right = 2'b11;

		// Second Channel
		middle_left = 2'b11;
		middle_middle = 2'b11;
		middle_right = 2'b11;

		// Third Channel
		bottom_left = 2'b11;
		bottom_middle = 2'b11;
		bottom_right = 2'b11;
		
		// win_condition_reg = 2'b00;
	
	end else
	
	if (rightSwitch == 0 && middleSwitch == 0 && leftSwitch == 0) begin

		case (selection)
			2'b00: begin
				top_right = turn;
				
			end
			
			2'b01: begin
				top_middle = turn;
				
			end
			
			2'b10: begin
				top_left = turn;
				
			end
		endcase
		
	end else if (rightSwitch == 1 && middleSwitch == 0 && leftSwitch == 0) begin

		case (selection)
			2'b00: begin
				middle_right = turn;
			end
			
			
			2'b01: begin
				middle_middle = turn;
			end
			
			2'b10: begin
				middle_left = turn;
			end
		
		endcase

	end else if (rightSwitch == 0 && middleSwitch == 1 && leftSwitch == 0) begin

		case (selection)
			2'b00: begin
				bottom_right = turn;
				
			end
			
			
			2'b01: begin
				bottom_middle = turn;
				
			end
			
			2'b10: begin
				bottom_left = turn;
				
			end
			
		endcase

	end 
	
	turnMod <= turnMod + 1'b1;
	turn = turnMod % 2'b10;


end
/*
check if both buttons are being held to reset the game

if both buttons are pressed at the same time, then the game reset and effectively change all (most?) of our variable to
its game starting value.
*/


//always @(win_condition_reg) begin
//
//	case (win_condition_reg)
//		2'b00: begin // no one win so, do nothing
//		test = 8'b11111111;
//		
//		end
//		
//		2'b01: begin // O win
//		
//		test = 8'b00000011;
//		
//		HEX_0_value = 3'b110;
//		HEX_1_value = 3'b101;
//		HEX_2_value = 3'b100;
//		
//		end
//		
//		2'b10: begin // X win
//		
//		test = 8'b10010001;
//		
//		HEX_0_value = 3'b110;
//		HEX_1_value = 3'b101;
//		HEX_2_value = 3'b100;
//		
//		
//		end
//		
//		
//	endcase
//
//
//end


// The Assigning Section
playerTurnDecoder(HEX_0_value, HEX_0);
playerTurnDecoder(HEX_1_value, HEX_1);
playerTurnDecoder(HEX_2_value, HEX_2);

assign HEX_3 = test; // empty box
channelDecoder(channelNumber, HEX_4);
playerTurnDecoder(turn, HEX_5);

endmodule