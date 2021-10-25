/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
	
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	wire [31:0] pc_out, pc_in;
	// output [31:0] pc_out;
	pc program_counter(pc_in, pc_out, clock, reset);
	four_byte_CSA pc_plus4(pc_out, 32'd1, 32'd0, pc_in);

	///////////////////////////////////////////////////////////////////////////////////////////////////////
	// Imem Section

	// Decode q_imem
	// R-type: Opcode = !a!b!c!d!e
	// I-type: Opcode = !ab!c!d!e+!a!bce+!a!bd!e
	// JI-type: Opcode = a!bcd!e + a!bc!de + !a!b!ce ,- else statement
	// JII-type: Opcode = !a!bc!d!e
	wire [31:0] insn;
	assign address_imem = pc_out[11:0];
	assign insn = q_imem;

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// Instruction Deconde Section
	wire [5:0] opCode;
	assign opCode = insn[31:27];
	wire is_Rtype, is_addi, is_lw, is_sw;
	wire DMwe, Rwe, Rwd, ReadRd, ALUinB;
	controller control_signals(opCode, is_Rtype, is_addi, is_lw, is_sw, DMwe, Rwe, Rwd, ReadRd, ALUinB);
	
	wire [4:0] rd, rs, rt;
	assign rd = insn[26:22];
	assign rs = insn[21:17];
	assign rt = ReadRd ? insn[26:22] : insn[16:12];
	wire [16:0] imm;
	assign imm = insn[16:0];
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// Regfile Section
    //output [31:0] data_writeReg;
	// sw: readreg from rd
	// lw: writeReg = rd
	assign ctrl_writeEnable = Rwe;
	assign ctrl_writeReg = rd;
	assign ctrl_readRegA = rs;
	assign ctrl_readRegB = rt;
	
		
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// ALU Section
	wire [4:0] ctrl_ALUopcode, ctrl_shiftamt;
	assign ctrl_ALUopcode = is_Rtype ? insn[6:2] : 5'd0;
	assign ctrl_shiftamt = is_Rtype ? insn[11:7] : 5'd0;
	wire [31:0] sx_imm;
	assign sx_imm = {{15{imm[16]}},imm};
	wire [31:0] data_operandA, data_operandB, data_result;
	wire isNotEqual, isLessThan, overflow;
	assign data_operandA = data_readRegA;
	assign data_operandB = ALUinB ? sx_imm : data_readRegB;
	alu execution(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// Dmem Section
	assign address_dmem = data_result[11:0];
	assign data = data_readRegB;
	assign wren = DMwe;
	assign data_writeReg = Rwd ? q_dmem : data_result;
	


endmodule
