module register(q, d, clk, en, clr);
	input [31:0] d;
	input clk, en, clr;
	output [31:0] q;
	
//	genvar i;
//		generate
//			for (i = 0; i < 31; i = i+1)
//			begin : dff_loop
//				dffe_ref dff0(q[i], d[i], clk, en, clr);
//			end
//	endgenerate
	dffe_ref dff0(q[0], d[0], clk, en, clr);
	dffe_ref dff1(q[1], d[1], clk, en, clr);
	dffe_ref dff2(q[2], d[2], clk, en, clr);
	dffe_ref dff3(q[3], d[3], clk, en, clr);
	dffe_ref dff4(q[4], d[4], clk, en, clr);
	dffe_ref dff5(q[5], d[5], clk, en, clr);
	dffe_ref dff6(q[6], d[6], clk, en, clr);
	dffe_ref dff7(q[7], d[7], clk, en, clr);
	dffe_ref dff8(q[8], d[8], clk, en, clr);
	dffe_ref dff9(q[9], d[9], clk, en, clr);
	dffe_ref dff10(q[10], d[10], clk, en, clr);
	dffe_ref dff11(q[11], d[11], clk, en, clr);
	dffe_ref dff12(q[12], d[12], clk, en, clr);
	dffe_ref dff13(q[13], d[13], clk, en, clr);
	dffe_ref dff14(q[14], d[14], clk, en, clr);
	dffe_ref dff15(q[15], d[15], clk, en, clr);
	dffe_ref dff16(q[16], d[16], clk, en, clr);
	dffe_ref dff17(q[17], d[17], clk, en, clr);
	dffe_ref dff18(q[18], d[18], clk, en, clr);
	dffe_ref dff19(q[19], d[19], clk, en, clr);
	dffe_ref dff20(q[20], d[20], clk, en, clr);
	dffe_ref dff21(q[21], d[21], clk, en, clr);
	dffe_ref dff22(q[22], d[22], clk, en, clr);
	dffe_ref dff23(q[23], d[23], clk, en, clr);
	dffe_ref dff24(q[24], d[24], clk, en, clr);
	dffe_ref dff25(q[25], d[25], clk, en, clr);
	dffe_ref dff26(q[26], d[26], clk, en, clr);
	dffe_ref dff27(q[27], d[27], clk, en, clr);
	dffe_ref dff28(q[28], d[28], clk, en, clr);
	dffe_ref dff29(q[29], d[29], clk, en, clr);
	dffe_ref dff30(q[30], d[30], clk, en, clr);
	dffe_ref dff31(q[31], d[31], clk, en, clr);
	
	

endmodule
