module shiftRA_by_5bit(data_operandA, ctrl_shiftamt, shiftRA_result);
	input [31:0] data_operandA;
	input [4:0] ctrl_shiftamt;
	output [31:0] shiftRA_result;
	
	wire [31:0] shiftR0, shiftR1, shiftR2, shiftR3;
	

// shift right 1 bit
//	mux_2_1 shiftR00(data_operandA[31], data_operandA[31], ctrl_shiftamt[0], shiftR0[31]);
	assign shiftR0[31] = data_operandA[31];
	genvar j;
	generate
		for (j = 30; j >= 0; j = j-1)
		begin : R0j
			mux_2_1 shiftR0j(data_operandA[j], data_operandA[j+1], ctrl_shiftamt[0], shiftR0[j]);
		end
	endgenerate

	// shift right 2 bit
	mux_2_1 shiftR10(shiftR0[31], data_operandA[31], ctrl_shiftamt[1], shiftR1[31]);
	mux_2_1 shiftR11(shiftR0[30], data_operandA[31], ctrl_shiftamt[1], shiftR1[30]);
	generate
		for (j = 29; j >= 0; j = j-1)
		begin : R1j
			mux_2_1 shiftR1j(shiftR0[j], shiftR0[j+2], ctrl_shiftamt[1], shiftR1[j]);
		end
	endgenerate
	
	
	// shift right 3 bit
	generate
		for (j = 31; j > 27; j = j-1)
		begin : R20
			mux_2_1 shiftR20(shiftR1[j], data_operandA[31], ctrl_shiftamt[2], shiftR2[j]);
		end
		for (j = 27; j >= 0; j = j-1)
		begin : R2j
			mux_2_1 shiftR2j(shiftR1[j], shiftR1[j+4], ctrl_shiftamt[2], shiftR2[j]);
		end
	endgenerate
	
	// shift right 4 bit
	generate
		for (j = 31; j > 23; j = j-1)
		begin : R30
			mux_2_1 shiftR30(shiftR2[j], data_operandA[31], ctrl_shiftamt[3], shiftR3[j]);
		end
		for (j = 23; j >= 0; j = j-1)
		begin : R3j
			mux_2_1 shiftR3j(shiftR2[j], shiftR2[j+8], ctrl_shiftamt[3], shiftR3[j]);
		end
	endgenerate
	
	

	// shift left 5 bit
	generate
		for (j = 31; j > 15; j = j-1)
		begin : R40
			mux_2_1 shiftR40(shiftR3[j], data_operandA[31], ctrl_shiftamt[4], shiftRA_result[j]);
		end
		for (j = 15; j >= 0; j = j-1)
		begin : R4j
			mux_2_1 shiftR4j(shiftR3[j], shiftR3[j+16], ctrl_shiftamt[4], shiftRA_result[j]);
		end
	endgenerate

endmodule
