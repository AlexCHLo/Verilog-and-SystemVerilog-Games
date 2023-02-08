//////////////////////////////////////////////
// parameter

// channel #1
// 8'b10011111;


// channel #2
// 8'b00100101

// channel #3
// 8'b00001101;



module channelDecoder (locationSymbol, hexBit);

input [2:0] locationSymbol;
output [7:0] hexBit;

reg [7:0] myValue;

always @(locationSymbol) begin

	case(locationSymbol)

		3'b000: myValue = 8'b10011111; // 1
		3'b001: myValue = 8'b00100101; // 2
		3'b010: myValue = 8'b00001101; // 3
		
	endcase

end

assign hexBit = myValue;



endmodule