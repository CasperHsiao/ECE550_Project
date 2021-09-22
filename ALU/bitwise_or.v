module bitwise_or(a,b,aOrb);
input[31:0]a,b;
output[31:0] aOrb;

	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : or_loop
			or bitwise_or(a[i], b[i], aOrb[i]);
		end
	endgenerate

endmodule
