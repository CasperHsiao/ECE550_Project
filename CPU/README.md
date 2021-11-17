# Full Processor Implementation - Checkpoint 5
## NetID : hma23 , ph139


## Design Implementation
**Modules:**
<ul>
<li>processor(clock,reset,address_imem,q_imem,address_dmem,
	q_dmem,cctrl_writeEnable,ctrl_writeReg,ctrl_readRegA,
	ctrl_readRegB,data_writeReg,ddata_readRegA,data_readRegB)</li>

<li>alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow)</li>

<li> four_byte_CSA(a, b, ci, s, co, overflow)</li>

<li>full_adder(a, b, ci, s, co)</li>

<li>regfile(
	clock, ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg, data_readRegA,
	data_readRegB
)</li>

<li>pc(pc_in, pc_out, clock, reset)</li>

<li>controller(opCode, is_Rtype, is_addi, is_lw, is_sw, DMwe, Rwe, Rwd, ReadRd, ALUinB)</li>

<li>clock_2 (clock_in, reset, clock_out);</li>

<li>clock_4 (clock_in, reset, clock_out);</li>
</ul>

### Processor (overall view)
we divided our Implementation to different sections
- Imem section (see README CP4)
- instruction Decode (see details below)
- Process overflow (see details below)
- Regfile (see README CP4)
- ALU section (provided by instructor)
- Dmem section (see README CP4)


### Program Counter "PC"

We started of with the PC , which is basically a 32 DFFEs . PC takes in 32 bits and outputs 32 bits which are then connected to our adder to add four.
we have pc_plus 0 to do pc+4 , and pc_plusN to deal with immediate instruction type

### controller and instruction decode

We assign the controller based on the ISA and instruction machine code format in the given project pdf file. For example, for R-type instruction, we set is_Rtype to 1, is_addi to 0, is_lw to 0, is_sw to 0, using the opcode as an input.

For the contol signals, that is DMwe, Rwe, Rwd, ReadRd, and ALUinB, we used random logic.
We assigned (for now since we may need to adjust this in Checkpoint 5):
<ul>
<li>
DMwe to is_sw (we eneable data write if the instruction is sw)
Rwe to is_Rtype|is_addi|is_lw|is_setx (we enable Register write if the instruction is R type or immediate or lw)
Rwd to is_lw (we set Rwd if we it is lw)
ReadRd is_sw | is_jr(We use this flag so we can deal with rt correctly)
ALUinB is_addi|is_lw|is_sw (if we need register B to bypass the ALU and do immediate instruction)
</li>
</ul>

For this Checkpoint we had to implement R and I type only. Hence, we assign rt
to either [26:22] or [16: 12] based on ReadRd since for store word we need to read from rt.

### Regfile

We assign the ctrl_writeEnable to Rwe, ctrl_writeReg to rd, ctrl_readRegA to rs, and ctrl_readRegB to rt.
(see the controller and instruction decode section above for the logic).

### ALU
The ALU opCode and ctrl_shiftamt will be controlled by the is_Rtype control signal. The data_operandB of the ALU will be controlled by the ALUinB control signal to take either the data_readRegB or the sign extention bits from the immediate.

### Process overflow
We did not successfully implemented the overflow function. Therefore, we commented out the part for the overflow process. Our thought process is that if overflow occurs there will be a mux to select register $30 for rd and the data_writeReg will select the rStatus value. We concluded that the error came from the clock and we would need to develop a better clock for the next Checkpoint.

### Dmem
Dmem is enabled by the control signal DMwe. The data to store to dmem is extracted from the data_readRegB. The data_writeReg will be controlled by Rwd to be either the data from dmem or ALU.
### new instructions (blt, bne , bex , j , jr , jal , setx)
our branch command works properly and as expected as we modified our controller to handle.
such commands (see the updated controller)
we have mux_BR that is defined as
(is_blt & (~isLessThan) & isNotEqual | is_bne & isNotEqual) ? pc_plusImm : pc_plus4
and mux_J that is defined as
is_jr ? data_readRegB : (is_bex & isNotEqual) ? usx_T : ((is_j | is_jal) ? usx_T : mux_BR)

note that mux_BR is in mux_J , this means we have a chain of logic.
that end up with mux_BR. Finally , mux_BR has pc_plusImm: pc_plus4
this means we either pc_plus Immediate or pc_plus +4 to fetch then
next instruction

### overflow process
we fixed our overflow from our mistakes in cp4, after adding the new instructions.

### clocking schemes
we have 2 clock divisors :
clock that divides by 2
clock that divides by 4
our clock scheme is as follows starting from the slowest clock:-
Processor -> Regfile -> Imem/Dmem
