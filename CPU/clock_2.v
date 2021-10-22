module clock_2 (clock_in, reset, clock_out);
	output reg clock_out;
	input clock_in;
	input reset;

	always @(posedge clock_in)
	begin
	if (reset)
		clock_out <= 1'b0;
	else
		clock_out <= ~clock_out;	
	end
endmodule
