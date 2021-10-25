module controller(opCode, is_Rtype, is_addi, is_lw, is_sw, DMwe, Rwe, Rwd, ReadRd, ALUinB);
	input [4:0]opCode;
	output is_Rtype, is_addi, is_lw, is_sw;
	output DMwe, Rwe, Rwd, ReadRd, ALUinB;
	
	wire [4:0]opCode;
	wire is_Rtype, is_addi, is_lw, is_sw;
	wire DMwe, Rwe, Rwd, Rdst, ALUinB;
	
	assign is_Rtype = (~opCode[4])&(~opCode[3])&(~opCode[2])&(~opCode[1])&(~opCode[0]); //00000
	assign is_addi = (~opCode[4])&(~opCode[3])&(opCode[2])&(~opCode[1])&(opCode[0]); //00101
	assign is_lw = (~opCode[4])&(opCode[3])&(~opCode[2])&(~opCode[1])&(~opCode[0]);//01000
	assign is_sw = (~opCode[4])&(~opCode[3])&(opCode[2])&(opCode[1])&(opCode[0]);//00111

	assign DMwe = is_sw;
	assign Rwe = is_Rtype|is_addi|is_lw;
	assign Rwd = is_lw;
	assign ReadRd = is_sw;
	assign ALUinB = is_addi|is_lw|is_sw;
	
endmodule
	
	
