module controller(opCode, is_Rtype, is_addi, is_lw, is_sw, DMwe, Rwe, Rwd, ReadRd, ALUinB, 
						is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx);
	input [4:0]opCode;
	output is_Rtype, is_addi, is_lw, is_sw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;
	output DMwe, Rwe, Rwd, ReadRd, ALUinB;
	
	wire [4:0]opCode;
	wire is_Rtype, is_addi, is_lw, is_sw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;
	wire DMwe, Rwe, Rwd, Rdst, ALUinB;
	
	assign is_Rtype = (~opCode[4])&(~opCode[3])&(~opCode[2])&(~opCode[1])&(~opCode[0]); //00000
	assign is_addi = (~opCode[4])&(~opCode[3])&(opCode[2])&(~opCode[1])&(opCode[0]); //00101
	assign is_lw = (~opCode[4])&(opCode[3])&(~opCode[2])&(~opCode[1])&(~opCode[0]);//01000
	assign is_sw = (~opCode[4])&(~opCode[3])&(opCode[2])&(opCode[1])&(opCode[0]);//00111
	
	assign is_j = (~opCode[4])&(~opCode[3])&(~opCode[2])&(~opCode[1])&(opCode[0]);//00001
	assign is_bne = (~opCode[4])&(~opCode[3])&(~opCode[2])&(opCode[1])&(~opCode[0]);//00010
	assign is_jal = (~opCode[4])&(~opCode[3])&(~opCode[2])&(opCode[1])&(opCode[0]);//00011
	assign is_jr = (~opCode[4])&(~opCode[3])&(opCode[2])&(~opCode[1])&(~opCode[0]);//00100
	assign is_blt = (~opCode[4])&(~opCode[3])&(opCode[2])&(opCode[1])&(~opCode[0]);//00110
	assign is_bex = (opCode[4])&(~opCode[3])&(opCode[2])&(opCode[1])&(~opCode[0]);//10110
	assign is_setx = (opCode[4])&(~opCode[3])&(opCode[2])&(~opCode[1])&(opCode[0]);//10101

	assign DMwe = is_sw;
	assign Rwe = is_Rtype|is_addi|is_lw;
	assign Rwd = is_lw;
	assign ReadRd = is_sw;
	assign ALUinB = is_addi|is_lw|is_sw;
	
endmodule
	
	
