module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	
   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

	wire co, not_arith_result;
	wire [31:0] negateB, selected_B, arith_result;
	
	wire [31:0] aORb, aANDb, logic_result;
	
	wire [31:0] arith_logic_result;		
	
	wire[31:0] shiftLL_result, shiftRA_result, shift_result;
	
	wire [30:0] notEqual;
	
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
	shiftRA_by_5bit shiftRA(data_operandA, ctrl_shiftamt, shiftRA_result);
	
	// Select shift left or right output.
	mux_2_1 select_shift(shiftLL_result, shiftRA_result, ctrl_ALUopcode[0], shift_result);
	
	
	// Select shift or arith_logic output. 
	mux_2_1 select_s2(arith_logic_result, shift_result, ctrl_ALUopcode[2], data_result);
	
	// A less than B
	not not31(not_arith_result, arith_result[31]);
	assign isLessThan = overflow ? not_arith_result : arith_result[31];
	
	// A not equal to B
	or or0(notEqual[0], arith_result[0], arith_result[1]);
	generate
		for (i = 1; i < 31; i = i+1)
		begin : notEqual_loop
			or or1(notEqual[i], notEqual[i-1], arith_result[i+1]);
		end
	endgenerate
	assign isNotEqual = notEqual[30];
	
	
endmodule
