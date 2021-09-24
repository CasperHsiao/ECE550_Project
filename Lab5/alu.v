module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	reg [31:0] data_result;

	always @(data_operandA or data_operandB or ctrl_ALUopcode)begin
	
	if(ctrl_ALUopcode == 5'b00010)
		data_result <= data_operandA & data_operandB;
	
	if(ctrl_ALUopcode == 5'b00011)
		data_result <= data_operandA | data_operandB;
		
	end
	
endmodule


