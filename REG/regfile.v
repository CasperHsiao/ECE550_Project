module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;
	
	wire [31:0] write_oneHot, write_enable, readA_oneHot, readB_oneHot;
	wire [31:0] q_reg0 [31:0];
	tri [31:0] data_readRegA, data_readRegB;

	// Write port
	decoder writeDecoder(ctrl_writeReg, write_oneHot);
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : and_loop
			and andEnable(write_enable[i], write_oneHot[i], ctrl_writeEnable);
		end
	endgenerate
	
	generate
		for (i = 1; i < 32; i = i+1)
		begin : write_loop
			register reg1(q_reg0[i], data_writeReg, clock, write_enable[i], ctrl_reset);
		end
	endgenerate
	
	register reg0(q_reg0[0], data_writeReg, clock, write_enable[0], 1'b1);
	
	// Read Port
	decoder readDecoderA(ctrl_readRegA,readA_oneHot);
	
	generate
		for (i = 0; i < 32; i = i+1)
		begin : tristate_buffer_loop
			triBuff readA(.out(data_readRegA), .in(q_reg0[i]), .ctrl(readA_oneHot[i]));
		end
	endgenerate
	
	
	
	decoder readDecoderB(ctrl_readRegB,readB_oneHot);

	generate
		for (i = 0; i < 32; i = i+1)
		begin : tristate_buffer_loop_B
			triBuff readB(.out(data_readRegB), .in(q_reg0[i]), .ctrl(readB_oneHot[i]));
		end
	endgenerate
	

endmodule
