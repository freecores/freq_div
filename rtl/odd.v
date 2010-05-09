
`include "defines.v"

module odd(clk, out, P, reset, enable);

	input clk;	// slow clock
	output out;
	input [`SIZE-1:0] P;
	input reset;
	input enable;

	reg [`SIZE-1:0] counter;
	reg [`SIZE-1:0] counter2;
	reg out_counter;
	reg out_counter2;
	reg rst_pulse;
	reg [`SIZE-1:0] old_P;
	wire not_zero;

	assign out = out_counter2 ^ out_counter;

	always @(posedge clk)
	begin
		if(reset | rst_pulse)
		begin
			counter <= P;
			out_counter <= 1;
		end
		else if (enable)
		begin
			if(counter == 1)
			begin
				counter <= P;
				out_counter <= ~out_counter;
			end
			else
			begin
				counter <= counter-1;
			end
		end
	end

	reg [`SIZE-1:0] initial_begin;
	wire [`SIZE:0] interm_3;
	assign interm_3 = {1'b0,P} + 3;

	always @(negedge clk)
	begin
		if(reset | rst_pulse)
		begin
			counter2 <= P;
			initial_begin <= interm_3[`SIZE:1];
			out_counter2 <= 1;
		end
		else if(initial_begin <= 1 && enable)
		begin
			if(counter2 == 1)
			begin
				counter2 <= P;
				out_counter2 <= ~out_counter2;
			end
			else
			begin
				counter2 <= counter2-1;
			end
		end
		else if(enable)
		begin
			initial_begin <= initial_begin - 1;
		end
	end

	always @(posedge clk or posedge reset)
	begin
		if(reset)
		begin
			rst_pulse <= 0;
		end
		else if(enable)
		begin
			if(P != old_P)
			begin
				rst_pulse <= 1;
			end
			else
			begin
				rst_pulse <= 0;
			end
			old_P <= P;
		end
	end

endmodule //odd
