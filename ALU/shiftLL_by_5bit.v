module shiftLL_by_5bit(data_operandA, ctrl_shiftamt, shiftLL_result);
	input [31:0] data_operandA;
	input [4:0] ctrl_shiftamt;
	output [31:0] shiftLL_result;
	
	wire [31:0] shiftL0, shiftL1, shiftL2, shiftL3;

// shift left 1 bit
	mux_2_1 shiftL00(data_operandA[0], 1'b0, ctrl_shiftamt[0], shiftL0[0]);
	genvar j;
	generate
		for (j = 1; j < 32; j = j+1)
		begin : L0j
			mux_2_1 shiftL0j(data_operandA[j], data_operandA[j-1], ctrl_shiftamt[0], shiftL0[j]);
		end
	endgenerate

	// shift left 2 bit
	mux_2_1 shiftL10(shiftL0[0], 1'b0, ctrl_shiftamt[1], shiftL1[0]);
	mux_2_1 shiftL11(shiftL0[1], 1'b0, ctrl_shiftamt[1], shiftL1[1]);
	generate
		for (j = 2; j < 32; j = j+1)
		begin : L1j
			mux_2_1 shiftL1j(shiftL0[j], shiftL0[j-2], ctrl_shiftamt[1], shiftL1[j]);
		end
	endgenerate
	
	
	// shift left 3 bit
	generate
		for (j = 0; j < 4; j = j+1)
		begin : L20
			mux_2_1 shiftL20(shiftL1[j], 1'b0, ctrl_shiftamt[2], shiftL2[j]);
		end
		for (j = 4; j < 32; j = j+1)
		begin : L2j
			mux_2_1 shiftL2j(shiftL1[j], shiftL1[j-4], ctrl_shiftamt[2], shiftL2[j]);
		end
	endgenerate
	
	// shift left 4 bit
	generate
		for (j = 0; j < 8; j = j+1)
		begin : L30
			mux_2_1 shiftL30(shiftL2[j], 1'b0, ctrl_shiftamt[3], shiftL3[j]);
		end
		for (j = 8; j < 32; j = j+1)
		begin : L3j
			mux_2_1 shiftL3j(shiftL2[j], shiftL2[j-8], ctrl_shiftamt[3], shiftL3[j]);
		end
	endgenerate
	
	

	// shift left 5 bit
	generate
		for (j = 0; j < 16; j = j+1)
		begin : L40
			mux_2_1 shiftL40(shiftL3[j], 1'b0, ctrl_shiftamt[4], shiftLL_result[j]);
		end
		for (j = 16; j < 32; j = j+1)
		begin : L4j
			mux_2_1 shiftL4j(shiftL3[j], shiftL3[j-16], ctrl_shiftamt[4], shiftLL_result[j]);
		end
	endgenerate

endmodule
