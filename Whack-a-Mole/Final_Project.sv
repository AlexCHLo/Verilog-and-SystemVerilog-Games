

module Final_Project (switch, btn0, btn1, clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, moleLED);


// ------------------- INPUT SWITCH -------------------

// realistically, you'll ohly need 4 bits. since we're focusing on only 1 decimal answer
// Work of Andre Tinico
input [8:0] switch;


// ------------------- INPUT BUTTON -------------------
input btn0;	// enter
input btn1;	// reset

// ------------------- CLOCK -------------------
input clk;

// ------------------- OUTPUT -------------------
// Work of Alex Lo
output [7:0] HEX0;
output [7:0] HEX1;
output [7:0] HEX2;
output [7:0] HEX3;
output [7:0] HEX4;
output [7:0] HEX5;


// MOLE LED
// Work of Andre Tinoco
output [10:0] moleLED;

// ------------------- REG/LOGIC -------------------

// only used to hold information
// work of Alex Lo
logic [7:0] HEX0_REG;
logic [7:0] HEX1_REG;
logic [7:0] HEX2_REG;
logic [7:0] HEX3_REG;
logic [7:0] HEX4_REG;
logic [7:0] HEX5_REG;

logic [7:0] HEX0_input;
logic [7:0] HEX1_input;
logic [7:0] HEX2_input;
logic [7:0] HEX3_input;
logic [7:0] HEX4_input;
logic [7:0] HEX5_input;

// USER INPUT
logic [7:0] USERINPUT;

logic [7:0] FIRST_number;
logic [7:0] SECOND_number;

// STUPID ASS CLOCK
logic [32:0] clockCounter;
logic [7:0] CLOCKDISPLAY;




// Work of Andre Tinoco
// WIN COUNTER
logic [3:0] winCounter = 0;

// MOLE VARIABLE
reg copied=0;
reg [9:0] moleLocation=10'b0000001000;
reg [9:0] originalPositions=10'd0;
reg [9:0] newPositions=10'd0;
reg [9:0] changes=10'd0;
reg [9:0] molePointer = 0;


// ------------------- DEFINED STATE -------------------
// Work of Alex Lo
localparam [3:0]
	start = 3'b000,
	math = 3'b001,
	mole = 3'b010,
	flip = 3'b011,
	finish = 3'b100;
	
	
logic [3:0] STATE = start;
	
// ------------------- LOGIC -------------------
// Work of Alex Lo
initial begin

	CLOCKDISPLAY = 5;
	FIRST_number <= 5;
	SECOND_number <= 4;

end

always @(posedge clk) begin

		case (STATE)
		
		// INIT
		// Work of Alex Lo
			start:
				begin
				
				HEX5_input <= 21;	// s
				HEX4_input <= 22;	// t
				HEX3_input <= 23;	// a
				HEX2_input <= 24;	// r
				HEX1_input <= 25;	// t
				HEX0_input <= 20;	// []
				
				
				// check if btn0 is pressed
				if (btn0 == 0) begin
					STATE <= math;
				end
					
				end
				
		// MATH MINI GAME
		// Work of Alex Lo
			math:
				begin
				
				// brokenass clock thingy
				clockCounter<= clockCounter + 1;
				
				// if clock exceed more than 5 seconds, then change state to finish
				
				if (clockCounter >= 50000000) begin
					CLOCKDISPLAY <= CLOCKDISPLAY - 1;
					clockCounter <= 0;
				end	
				
				// only want the first 3 switch since it can have a max number of 7. 
				// Good enough for a 1 decimal question
				USERINPUT[0] <= switch[0];
				USERINPUT[1] <= switch[1];
				USERINPUT[2] <= switch[2];
				
				
				HEX5_input <= FIRST_number;	// FIRST NUMBER
				HEX4_input <= 30;	// [-]
				HEX3_input <= SECOND_number;	// SECOND NUMBER
				HEX2_input <= 31;	// [=]
				HEX1_input <= USERINPUT;	// USER INPUT
				HEX0_input <= CLOCKDISPLAY;
				
				
				
				if (btn0 == 0) begin
				
					if (FIRST_number - SECOND_number == USERINPUT) begin
					
						// First number must be around 5-9
						// Second number must be around 2-4
						FIRST_number <= FIRST_number + 1;
						SECOND_number <= SECOND_number - 1;
						
						if (FIRST_number == 10) begin
							FIRST_number <= 5;
						
						end
						
						if (SECOND_number == 1) begin
							SECOND_number <= 4;
							
						end
						
						clockCounter <= 0;
						winCounter <= winCounter + 1;
						CLOCKDISPLAY <= 5;
						STATE<= mole;
					
					end
				
				
				end
				
				if (CLOCKDISPLAY == 0) begin
					STATE <= finish;
						
				end
				
				
				
				end
				
// -------------------------------- WHACK A MOLE --------------------------------
		
			mole: begin
			// work of Andre Tinoco
			
				clockCounter <= clockCounter + 1;
				newPositions <= switch;
				
				// if clock exceed more than 5 seconds, then change state to finish
				if (clockCounter >= 50000000) begin
					CLOCKDISPLAY <= CLOCKDISPLAY - 1;
					clockCounter <= 0;
					originalPositions <= switch;
					
				end	

				
				// stores the original way the switches are set
				// E.g. 
				if(copied==0) begin
					originalPositions<=switch;
					copied<=1;
			
				end
				
				//compare changes with the mole using XOR
            changes<= newPositions ^ originalPositions;
            
							
				HEX5_input <= 32;	// N [requires two n's to make an m]
				HEX4_input <= 33;	// N
				HEX3_input <= 34;	// O
				HEX2_input <= 35;	// L
				HEX1_input <= 36;	// E
				HEX0_input <= CLOCKDISPLAY;
				
				
				//if theyre equal then they win the game
            if(changes == moleLocation) begin //WIN GAME
					
					molePointer <= molePointer + 1;
					
					if (molePointer == 10) begin
					
						molePointer <= 1;
					
					end
					
					case (molePointer)
						1: moleLocation <= 10'b0010000000;
						2: moleLocation <= 10'b1000000000;
						3: moleLocation <= 10'b0100000000;
						4: moleLocation <= 10'b0000010000;
						5: moleLocation <= 10'b0001000000;
						6: moleLocation <= 10'b0000000010;
						7: moleLocation <= 10'b0000000100;
						8: moleLocation <= 10'b0000001000;
						9: moleLocation <= 10'b0000000001;
						
					endcase
					
					changes<=10'd0;
					originalPositions <= 10'd0;
					newPositions <= 10'd0;
					copied <= 0;
					
				
					clockCounter <= 0;
					winCounter <= winCounter + 1;
					CLOCKDISPLAY <= 5;
					
					STATE <= math;
					

            end
				
				if (CLOCKDISPLAY == 0) begin
					STATE <= finish;
			
				end
				
				
		
			
			end
// --------------------------------------------------------------------------------------
			
			
// -------------------------------- UNABLE TO MAKE IT WORK ON IT --------------------------------
//			// FLIP THE BOARD
//			
//			flip: begin
//			
//			end
// --------------------------------------------------------------------------------------
			
			
			
		// END OF THE GAME THING. MUST RESET
			finish:
				begin
				HEX5_input <= 26;	// d
				HEX4_input <= 27;	// o
				HEX3_input <= 28;	// n
				HEX2_input <= 29;	// e
				HEX1_input <= 20;	// []
				HEX0_input <= winCounter;	// []
				
				// MUST RESET IF YOU WANT TO REPLAY
				if (btn1 == 0) begin
					STATE <= start;
					clockCounter <= 0;
					winCounter <= 0;
					CLOCKDISPLAY <= 5;
					originalPositions <= 10'd0;
					newPositions <= 10'd0;
					copied <= 0;
					
					
				
				end
				
			end
		endcase
		


end

// ------------------- MOLE LED DISPLAY -------------------
// Work of Andre Tinoco

assign moleLED = moleLocation * (STATE == mole);

// ------------------- HEX DISPLAY -------------------

// Work of Alex Lo

decimalToHex(HEX0_input, HEX0_REG);
decimalToHex(HEX1_input, HEX1_REG);
decimalToHex(HEX2_input, HEX2_REG);
decimalToHex(HEX3_input, HEX3_REG);
decimalToHex(HEX4_input, HEX4_REG);
decimalToHex(HEX5_input, HEX5_REG);

// Work of Alex Lo

SEVENSEG_OUTPUT(HEX0_REG, HEX0);
SEVENSEG_OUTPUT(HEX1_REG, HEX1);
SEVENSEG_OUTPUT(HEX2_REG, HEX2);
SEVENSEG_OUTPUT(HEX3_REG, HEX3);
SEVENSEG_OUTPUT(HEX4_REG, HEX4);
SEVENSEG_OUTPUT(HEX5_REG, HEX5);


endmodule