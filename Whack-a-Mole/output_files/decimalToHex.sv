module decimalToHex(Decimal, Hex);

	input [8:0]  Decimal;
	output [8:0]  Hex;
	
	reg [8:0] decimal_reg;
	
	
always @(*) begin

	case (Decimal) 
	
		7'd0: decimal_reg = 8'b00000011; // 0
		7'd1:	decimal_reg = 8'b10011111; // 1
		7'd2: decimal_reg = 8'b00100101; // 2
		7'd3:	decimal_reg = 8'b00001101; // 3
		7'd4:	decimal_reg = 8'b10011001; // 4
		7'd5:	decimal_reg = 8'b01001001; // 5
		7'd6:	decimal_reg = 8'b01000001; // 6
		7'd7:	decimal_reg = 8'b00011111; // 7
		7'd8:	decimal_reg = 8'b00000001; // 8
		7'd9: decimal_reg = 8'b00001001; // 9
		
		
		7'd20: decimal_reg = 8'b11111111; 
		// [S]TART
		7'd21: decimal_reg = 8'b01001001;
		// S[T]ART
		7'd22: decimal_reg = 8'b11100001;
		// ST[A]RT
		7'd23: decimal_reg = 8'b00010001;
		// STA[R]T
		7'd24: decimal_reg = 8'b11110101;
		// STAR[T]
		7'd25: decimal_reg = 8'b11100001;
		// [D]ONE
		7'd26: decimal_reg = 8'b10000101;
		// D[O]NE
		7'd27: decimal_reg = 8'b11000101;
		// DO[N]E
		7'd28: decimal_reg = 8'b11010101;
		// DON[E]
		7'd29: decimal_reg = 8'b00100001;
		// [-]
		7'd30: decimal_reg = 8'b11111101;
		// [=]
		7'd31: decimal_reg = 8'b11101101;
		// [M]OLE
		7'd32: decimal_reg = 8'b11010101;
		// [M]OLE
		7'd33: decimal_reg = 8'b11010101;
		// M[O]LE
		7'd34: decimal_reg = 8'b11000101;
		// MO[l]E
		7'd35: decimal_reg = 8'b10011111;
		// MOL[E]
		7'd36: decimal_reg = 8'b00100001;
	
	endcase
	
end
	
	

	assign Hex[0] = decimal_reg[0];
	assign Hex[1] = decimal_reg[1];
	assign Hex[2] = decimal_reg[2];
	assign Hex[3] = decimal_reg[3];
	assign Hex[4] = decimal_reg[4];
	assign Hex[5] = decimal_reg[5];
	assign Hex[6] = decimal_reg[6];
	assign Hex[7] = decimal_reg[7];
	

endmodule


