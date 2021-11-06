# Full Processor Implementation - Checkpoint 5
## NetID : hma23 , ph139


## Design Implementation
**Modules:**
<ul>
<li>processor(clock,reset,address_imem,q_imem,address_dmem,q_dmem,cctrl_writeEnable,ctrl_writeReg,ctrl_readRegA,ctrl_readRegB,data_writeReg,ddata_readRegA,data_readRegB)</li>
<li>alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow)</li>
<li> four_byte_CSA(a, b, ci, s, co, overflow)</li>
<li>mux_2_1(a , b, sel, out)</li>
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

### Program Counter "PC"

We started of with the PC , which is basically a 32 DFFEs . PC takes in 32 bits and outputs 32 bits which are then connected to our adder to add four.
### controller and instruction decode

We assign the controller based on the given OPcodes in the pdf file.
For example , For R-type instruction we set is_Rtype to 00000, is_addi to 00101, is_lw to 01000, is_sw to 00111, using the opcode as an input.

For the Enables , that is DMwe,Rwe,Rwd,ReadRd,and ALUinB. we assign (for now since we may need to adjust this in CP5):-
DMwe to is_sw (we eneable data write if the instruction is sw)
Rwe to is_Rtype|is_addi|is_lw|is_setx (we enable Register write if the instruction is R type or immediate or lw)
Rwd to is_lw (we set Rwd if we it is lw)
ReadRd is_sw | is_jr(We use this flag so we can deal with rt correctly)
ALUinB is_addi|is_lw|is_sw (if we need register B to bypass the ALU and do immediate instruction)

For this CP we had to implement R and I type only. Hence, we assign rt
to either [26:22] or [16: 12] based on ReadRd since for store word we need to read from
rt.

### Regfile

we assign the ctrl_writeEnable to Rwe, ctrl_writeReg to rd.
and ctrl_readRegA to rs . ctrl_readRegB to rt.

(see the controller and instruction decode section above for the logic).

### overflow process
we fixed our overflow from our mistakes in cp4

### added (bne , bex , j , jr,jal)
our branch command works properly and as expected as we modified our controller to handle
such commands (see the updated controller)
