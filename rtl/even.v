
`include "defines.v"

module even(clk, out, P, reset, not_zero);

	input clk;
	output out;
	input [`SIZE-1:0] P;
	input reset;
	input not_zero;

	reg [`SIZE-1:0] counter;
	reg out_counter;
	wire [`SIZE-1:0] div_2;


	assign out = (clk & !not_zero) | (out_counter & not_zero);
	assign div_2 = {1'b0, P[`SIZE-1:1]};

	always @(posedge reset or posedge clk)
	begin
		if(reset)
		begin
			counter <= 1;
			out_counter <= 1;
		end
		else
		begin
			if(counter == 1)
			begin
				counter <= div_2;
				out_counter <= ~out_counter;
			end
			else
			begin
				counter <= counter-1;
			end
		end
	end

endmodule //even
