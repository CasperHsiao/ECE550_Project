module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	
   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

	wire co;
	wire [31:0] negateB, selected_B, arith_result;
	
	wire [31:0] aORb, aANDb, logic_result;
	
	wire [31:0] arith_logic_result;
	
	
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
	
	
	
	
	
	
	

	
endmodule
