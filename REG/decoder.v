module decoder(ctrl, one_hot);
	input [4:0] ctrl;
	output [31:0] one_hot;
	
	wire [4:0] not_ctrl;
	
	genvar i;
	generate
		for (i = 0; i < 5; i = i+1)
		begin : not_loop
			not bitwise_not(not_ctrl[i], ctrl[i]);
		end
	endgenerate
	
	and and0(one_hot[0], not_ctrl[4], not_ctrl[3], not_ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and1(one_hot[1], not_ctrl[4], not_ctrl[3], not_ctrl[2], not_ctrl[1], ctrl[0]);
	and and2(one_hot[2], not_ctrl[4], not_ctrl[3], not_ctrl[2], ctrl[1], not_ctrl[0]);
	and and3(one_hot[3], not_ctrl[4], not_ctrl[3], not_ctrl[2], ctrl[1], ctrl[0]);
	and and4(one_hot[4], not_ctrl[4], not_ctrl[3], ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and5(one_hot[5], not_ctrl[4], not_ctrl[3], ctrl[2], not_ctrl[1], ctrl[0]);
	and and6(one_hot[6], not_ctrl[4], not_ctrl[3], ctrl[2], ctrl[1], not_ctrl[0]);
	and and7(one_hot[7], not_ctrl[4], not_ctrl[3], ctrl[2], ctrl[1], ctrl[0]);
	and and8(one_hot[8], not_ctrl[4], ctrl[3], not_ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and9(one_hot[9], not_ctrl[4], ctrl[3], not_ctrl[2], not_ctrl[1], ctrl[0]);
	and and10(one_hot[10], not_ctrl[4], ctrl[3], not_ctrl[2], ctrl[1], not_ctrl[0]);
	and and11(one_hot[11], not_ctrl[4], ctrl[3], not_ctrl[2], ctrl[1], ctrl[0]);
	and and12(one_hot[12], not_ctrl[4], ctrl[3], ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and13(one_hot[13], not_ctrl[4], ctrl[3], ctrl[2], not_ctrl[1], ctrl[0]);
	and and14(one_hot[14], not_ctrl[4], ctrl[3], ctrl[2], ctrl[1], not_ctrl[0]);
	and and15(one_hot[15], not_ctrl[4], ctrl[3], ctrl[2], ctrl[1], ctrl[0]);
	and and16(one_hot[16], ctrl[4], not_ctrl[3], not_ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and17(one_hot[17], ctrl[4], not_ctrl[3], not_ctrl[2], not_ctrl[1], ctrl[0]);
	and and18(one_hot[18], ctrl[4], not_ctrl[3], not_ctrl[2], ctrl[1], not_ctrl[0]);
	and and19(one_hot[19], ctrl[4], not_ctrl[3], not_ctrl[2], ctrl[1], ctrl[0]);
	and and20(one_hot[20], ctrl[4], not_ctrl[3], ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and21(one_hot[21], ctrl[4], not_ctrl[3], ctrl[2], not_ctrl[1], ctrl[0]);
	and and22(one_hot[22], ctrl[4], not_ctrl[3], ctrl[2], ctrl[1], not_ctrl[0]);
	and and23(one_hot[23], ctrl[4], not_ctrl[3], ctrl[2], ctrl[1], ctrl[0]);
	and and24(one_hot[24], ctrl[4], ctrl[3], not_ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and25(one_hot[25], ctrl[4], ctrl[3], not_ctrl[2], not_ctrl[1], ctrl[0]);
	and and26(one_hot[26], ctrl[4], ctrl[3], not_ctrl[2], ctrl[1], not_ctrl[0]);
	and and27(one_hot[27], ctrl[4], ctrl[3], not_ctrl[2], ctrl[1], ctrl[0]);
	and and28(one_hot[28], ctrl[4], ctrl[3], ctrl[2], not_ctrl[1], not_ctrl[0]);
	and and29(one_hot[29], ctrl[4], ctrl[3], ctrl[2], not_ctrl[1], ctrl[0]);
	and and30(one_hot[30], ctrl[4], ctrl[3], ctrl[2], ctrl[1], not_ctrl[0]);
	and and31(one_hot[31], ctrl[4], ctrl[3], ctrl[2], ctrl[1], ctrl[0]);
	

endmodule
