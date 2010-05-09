
`include "defines.v"

module divider(in, out, P, reset);

	input in;
	input [`SIZE-1:0] P;
	input reset;
	output out;
	
	wire out_odd;
	wire out_even;
	wire not_zero;

	assign not_zero = | P[`SIZE-1:1];

	assign out = (out_odd & P[0] & not_zero) | (out_even & !P[0]);

	even even_0(in, out_even, P, reset, not_zero);
	odd odd_0(in, out_odd, P, reset);
	
endmodule //divider
