module SEVENSEG_OUTPUT(HEX_REG, HEX_WIRE);

	input wire [7:0]  HEX_REG;
	output [7:0]  HEX_WIRE;

	assign HEX_WIRE[0] = HEX_REG[0];
	assign HEX_WIRE[1] = HEX_REG[1];
	assign HEX_WIRE[2] = HEX_REG[2];
	assign HEX_WIRE[3] = HEX_REG[3];
	assign HEX_WIRE[4] = HEX_REG[4];
	assign HEX_WIRE[5] = HEX_REG[5];
	assign HEX_WIRE[6] = HEX_REG[6];
	assign HEX_WIRE[7] = HEX_REG[7];

endmodule
