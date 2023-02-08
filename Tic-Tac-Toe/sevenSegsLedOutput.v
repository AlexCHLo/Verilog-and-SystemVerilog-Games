// previously from lab 3 and lab 2. this is my own work.

// slight change because the led input was wired backword. 

module sevenSegsLedOutput(fourBitBinary, sevenSegsLED);

	input wire [3:0]  fourBitBinary;
	output [6:0]  sevenSegsLED;
	
	wire a = fourBitBinary[3];
	wire b = fourBitBinary[2];
	wire c = fourBitBinary[1];
	wire d = fourBitBinary[0];
	
	reg zero;
	reg one;
	reg two;
	reg three;
	reg four;
	reg five;
	reg six;

	always @(a,b,c,d) 
	begin
	
	// I used the k-map to find the smallest
	zero = ~((~b & ~d) | (~a & c) | (~a & b & d) | (a & ~b & ~c) | (a & ~d) | (b & c));
	one = ~((a | ~b | c | ~d) & (~b | ~c | d) & (~a | ~c | ~d) & (~a | ~b | d));
	two = ~((a | b | ~c | d) & (~a | ~b | d) & (~a | ~b | ~c));
	three = ~((a | b | c | ~d) & (a | ~b | c | d) & (~b | ~c | ~d) & (~a | b | ~c | d));
	four = ~((a | ~d) & (a | ~b | c) & (b | c | ~d));
	five = ~((a | b | ~d) & (a | b | ~c) & (a | ~c | ~d) & (~a | ~b | c | ~d));	
	six = ~((a | b | c) & (a | ~b | ~c | ~d) & (~a | ~b | c | d));

	end
	
	// kind of sketch, hope this meets the requirement of having one input and one output.
	assign sevenSegsLED[0] = six;
	assign sevenSegsLED[1] = five;
	assign sevenSegsLED[2] = four;
	assign sevenSegsLED[3] = three;
	assign sevenSegsLED[4] = two;
	assign sevenSegsLED[5] = one;
	assign sevenSegsLED[6] = zero;


endmodule


