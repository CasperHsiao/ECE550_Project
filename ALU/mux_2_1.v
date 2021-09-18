module mux_2_1(a , b, sel, out);

	input [31:0] a,b;
	input sel;
	
	output [31:0] out;
	
	assign out = sel ? b : a;

endmodule
