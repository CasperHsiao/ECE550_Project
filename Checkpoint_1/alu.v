module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	
   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

	wire co;
	wire [31:0] negateB, result_B;
	
	
	// Checkpoint 1:
	// ADD, SUBTRACT
	// Inputs: OperandA and OperandB ALUopcode
	// Outputs: data_result and overflow
	
	// Negates data_operand_B
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : not_loop
			not u_not(negateB[i], data_operandB[i]);
		end
	endgenerate
	
	// Choose the right operand for B (positive B or negative B) according to the ALUopcode
	mux_2_1 choose_OP(data_operandB, negateB, ctrl_ALUopcode[0], result_B);
	
	// Do the addition of operand A and operand B
	four_byte_CSA csaSUB(data_operandA, result_B, ctrl_ALUopcode[0], data_result, co, overflow);
	// End of Checkpoint1
	
endmodule
