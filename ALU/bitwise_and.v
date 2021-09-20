module bitwise_and(a,b,aAndb);
input[31:0]a,b;
output[31:0] aAndb;

	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : and_loop
			and bitwise_and(a[i], b[i], aAndb[i]);
		end
	endgenerate

endmodule
