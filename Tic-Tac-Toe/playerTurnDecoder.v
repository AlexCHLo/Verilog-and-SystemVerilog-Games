//////////////////////////////////////////////////
// parameter
// if playerSymbol = 2'b00, then return 0
// if playerSymol = 2'b01, then return X
// if playerSymbol = 2'b10, then return Unders
// if playerSymbol = 2'b11, then return " "




module playerTurnDecoder (playerSymbol, hexBit);

input [3:0] playerSymbol;
output [7:0] hexBit;

reg [7:0] myValue;

always @(playerSymbol) begin

	case(playerSymbol)
	
		2'b00: myValue = 8'b00000011; //
		2'b01: myValue = 8'b10010001;
		2'b10: myValue = 8'b11101111;
		2'b11: myValue = 8'b11111111; 
		
		3'b100: myValue = 8'b00001101; // sideway W
		3'b101: myValue = 8'b11111101; // sideway i
		3'b110: myValue = 8'b01100011; // sideway n
		
	endcase

end

assign hexBit = myValue;

endmodule