
// Parameter

// input
// if playerSymbol = 2'b00, then return 0
// if playerSymol = 2'b01, then return X
// if playerSymbol = 2'b10, then return Unders
// if playerSymbol = 2'b11, then return " "

// output
// 2'b00 --> no one win yet
// 2'b01 --> O win
// 2'b10 --> X win



module ticTacToe_Win_Condition(top_left, top_middle,top_right,middle_left,middle_middle,middle_right,bottom_left,bottom_middle,bottom_right, win_condition);

// First Channel
input [2:0] top_left;
input [2:0] top_middle;
input [2:0] top_right;

// Second Channel
input [2:0] middle_left;
input [2:0] middle_middle;
input [2:0] middle_right;

// Third Channel
input [2:0] bottom_left;
input [2:0] bottom_middle;
input [2:0] bottom_right;

// is Win True?
output [2:0] win_condition;

reg [2:0] win_condition_reg;


// input
// if playerSymbol = 2'b00, then return 0
// if playerSymol = 2'b01, then return X
// if playerSymbol = 2'b10, then return Unders
// if playerSymbol = 2'b11, then return " "

// output
// 2'b00 --> no one win yet
// 2'b01 --> O win
// 2'b10 --> X win


always @(top_left, top_middle,top_right,middle_left,middle_middle,middle_right,bottom_left,bottom_middle,bottom_right) begin


	// Since there are 9 different possible ways
	// i realize that if I do the k-map, I need to do 512 cells and that's kind of painful tbh. lets brute force it for now
	// im sorry that I couldn't think up a clever method that would let me reduce this chunky number of line codes.

	// checking for O winning. pretty scuffed, but it is what it is.

	// horizontal for O
	if (top_left == 2'b00 && top_middle == 2'b00 && top_right == 2'b00) begin
	
		win_condition_reg = 2'b01;

	end else if (middle_left == 2'b00 && middle_middle == 2'b00 && middle_right == 2'b00) begin
	
		win_condition_reg = 2'b01;

	end else if (bottom_left == 2'b00 && bottom_middle == 2'b00 && bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b01;

	end else

	// vertical for O
	if (top_left == 2'b00 && middle_left == 2'b00 &&  bottom_left == 2'b00) begin
	
		win_condition_reg = 2'b01;

	end else if (top_middle == 2'b00 && middle_middle == 2'b00 &&  bottom_middle == 2'b00) begin
	
		win_condition_reg = 2'b01;

	end else if (top_right == 2'b00 && middle_right  == 2'b00 &&  bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b01;

	end else

	// diagionally for 0
	if (top_left == 2'b00 && middle_middle == 2'b00 &&  bottom_right == 2'b00) begin

		win_condition_reg = 2'b10;

	end else if (top_right == 2'b00 && middle_middle == 2'b00 &&  bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else

	////////////////////////////////////////////////////////////////////////////////////////////

	// horizontal for X
	if (top_left == 2'b00 && top_middle == 2'b00 && top_right == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else if (middle_left == 2'b00 && middle_middle == 2'b00 && middle_right == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else if (bottom_left == 2'b00 && bottom_middle == 2'b00 && bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else

	// vertical for X
	if (top_left == 2'b00 && middle_left == 2'b00 &&  bottom_left == 2'b00) begin
	
		win_condition_reg = 2'b10;
	
	end else if (top_middle == 2'b00 && middle_middle == 2'b00 &&  bottom_middle == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else if (top_right == 2'b00 && middle_right  == 2'b00 &&  bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else

	// diagionally for X
	if (top_left == 2'b00 && middle_middle == 2'b00 &&  bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b10;

	end else if (top_right == 2'b00 && middle_middle == 2'b00 &&  bottom_right == 2'b00) begin
	
		win_condition_reg = 2'b10;
	
	end 
	
end 

assign win_condition = win_condition_reg;



endmodule