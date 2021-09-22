module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	
   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

	wire co;
	wire [31:0] negateB, selected_B, arith_result;
	
	wire [31:0] aORb, aANDb, logic_result;
	
	wire [31:0] arith_logic_result;
	
	wire [31:0] shiftL1,shiftL2,shiftL3,shiftL4,shiftL5; 
	
	wire[31:0] shiftLL_result,shiftAR_result,shift_result;
	
	// Checkpoint 1:
	// ADD, SUBTRACT
	// Inputs: OperandA and OperandB ALUopcode
	// Outputs: data_result and overflow
	
	// logical operations (and,or,neg)
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : logic_loop
			not bitwise_not(negateB[i], data_operandB[i]);
			or bitwise_or(aORb[i], data_operandA[i], data_operandB[i]);
			and bitwise_and(aANDb[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate
	
	// Choose the right operand for B (positive B or negative B) according to the ALUopcode
	mux_2_1 choose_arith(data_operandB, negateB, ctrl_ALUopcode[0], selected_B);
	
	// Do the addition of operand A and operand B
	four_byte_CSA arith(data_operandA, selected_B, ctrl_ALUopcode[0], arith_result, co, overflow);
	// End of Checkpoint1
	
	
	
	// Start of Checkpoint2
	// Select logical unit output
	mux_2_1 choose_logic(aANDb, aORb, ctrl_ALUopcode[0], logic_result);
	
	// Select logical OP or arithmetic OP
	mux_2_1 choose_OP(arith_result, logic_result, ctrl_ALUopcode[1], arith_logic_result);
	
	assign data_result = arith_logic_result;
	
	mux_2_1 choose_shift(shiftLL_result, shiftAR_result, ctrl_ALUopcode[2], shift_result);
	assign data_result = shift_result;
	
	// shift left 1 bit
		
	mux_2_1 shiftL0(data_operandA[0], 1'b0, ctrl_shiftamt[0], shiftL1[0]);
	genvar j;
	generate
		for (j = 0; j < 31; j = j+1)
		begin : muxesLayer1
			mux_2_1 muxesLayer(data_operandA[j+1], data_operandA[j], ctrl_shiftamt[0], shiftL1[j+1]);
		end
	endgenerate

	
	mux_2_1 shiftL2_0(shiftL1[0], 1'b0, ctrl_shiftamt[0], shiftL2[0]);
	generate
		for (j = 0; j < 31; j = j+1)
		begin : muxesLayer2
			mux_2_1 muxesLayer(shiftL1[j+1], shiftL1[j], ctrl_shiftamt[0], shiftL2[j+1]);
		end
	endgenerate
	
	
		mux_2_1 shiftL3_0(shiftL2[0], 1'b0, ctrl_shiftamt[0], shiftL3[0]);
	generate
		for (j = 0; j < 31; j = j+1)
		begin : muxesLayer3
			mux_2_1 muxesLayer(shiftL2[j+1], shiftL2[j], ctrl_shiftamt[0], shiftL3[j+1]);
		end
	endgenerate
	
	
		mux_2_1 shiftL4_0(shiftL3[0], 1'b0, ctrl_shiftamt[0], shiftL4[0]);
	generate
		for (j = 0; j < 31; j = j+1)
		begin : muxesLayer4
			mux_2_1 muxesLayer(shiftL3[j+1], shiftL3[j], ctrl_shiftamt[0], shiftL4[j+1]);
		end
	endgenerate
	
	

		mux_2_1 shiftL5_0(shiftL2[0], 1'b0, ctrl_shiftamt[0], shiftL5[0]);
	generate
		for (j = 0; j < 31; j = j+1)
		begin : muxesLayer5
			mux_2_1 muxesLayer(shiftL4[j+1], shiftL4[j], ctrl_shiftamt[0], shiftL5[j]);
		end
	endgenerate
	
	
	
endmodule
