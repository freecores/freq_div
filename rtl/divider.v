
`include "defines.v"

module divider(in, out, P, reset);

	input in;
	input [`SIZE-1:0] P;
	input reset;
	output out;
	
	wire out_odd;
	wire out_even;
	wire not_zero;
	wire enable_even;
	wire enable_odd;

	assign not_zero = | P[`SIZE-1:1];

	assign out = (out_odd & P[0] & not_zero) | (out_even & !P[0]);
	//assign out = out_odd | out_even;
	assign enable_odd = P[0] & not_zero;
	assign enable_even = !P[0];

	even even_0(in, out_even, P, reset, not_zero, enable_even);
	odd odd_0(in, out_odd, P, reset, enable_odd);
	
endmodule //divider
