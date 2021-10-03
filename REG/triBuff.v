module triBuff(out, in, ctrl);
	input [31:0] in;
	input ctrl;
	output [31:0] out;
	
	assign out = ctrl ? in : 32'bz;
	
endmodule
