module pc(pc_in, pc_out, clock, reset);
	input clock, reset;
	input [31:0]pc_in;
	output [31:0]pc_out;
	
	genvar i;
	generate
	for (i = 0; i < 32; i = i + 1)
	begin : pc
		dffe_ref pcFF(pc_out[i], pc_in[i], clock, 1'b1, reset);
	end
	endgenerate


endmodule
