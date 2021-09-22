module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	
   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

	wire co;
	wire [31:0] negateB, selected_B, arith_result;
	
	wire [31:0] aORb, aANDb, logic_result;
	
	wire [31:0] arith_logic_result;
	

	wire [31:0] shiftR0, shiftR1,shiftR2,shiftR3,shiftR4; 	
	
	wire[31:0] shiftLL_result, shiftAR_result, shift_result;
	
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
	
	// Select the right operand for B (positive B or negative B) according to the ALUopcode.
	mux_2_1 select_arith(data_operandB, negateB, ctrl_ALUopcode[0], selected_B);
	
	// Compute arithmetic output.
	four_byte_CSA arith(data_operandA, selected_B, ctrl_ALUopcode[0], arith_result, co, overflow);
	// End of Checkpoint1
	
	
	
	// Start of Checkpoint2
	
	// Select logical unit output.
	mux_2_1 select_logic(aANDb, aORb, ctrl_ALUopcode[0], logic_result);
	
	// Select logical or arithmetic output.
	mux_2_1 select_s1(arith_result, logic_result, ctrl_ALUopcode[1], arith_logic_result);
	
	// Compute shift left.
	shiftLL_by_5bit shiftLL(data_operandA, ctrl_shiftamt, shiftLL_result);
	
	// Compute shift right.
//	shiftAR_by_5bit shiftAR(data_operandA, ctrl_shiftamt, shiftAR_result);
	
	// Select shift left or right output.
	mux_2_1 select_shift(shiftLL_result, shiftAR_result, ctrl_ALUopcode[0], shift_result);
	
	
	// Select shift or arith_logic output. 
	mux_2_1 select_s2(arith_logic_result, shift_result, ctrl_ALUopcode[2], data_result);
	
	// A less than B
	xor lessthan(isLessThan, arith_result[31], overflow);
	
	// A not equal to B
	mux_2_1 isnotequal(arith_result,1'b0,1'b0,isNotEqual);
	
	
endmodule
