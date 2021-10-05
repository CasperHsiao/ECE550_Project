# Reg file Implementation - Checkpoint 3
## NetID : hma23 , ph139



## Design Implementation
**Modules:**
<ul>
<li>regfile(clock,ctrl_writeEnable,ctrl_reset, ctrl_writeReg,ctrl_readRegA, ctrl_readRegB, data_writeReg,data_readRegA, data_readRegB);</li>
<li>dffe_ref(q, d, clk, en, clr);</li>
<li>register(q, d, clk, en, clr);</li>
<li>decoder(ctrl, one_hot);</li>
<li>triBuff(out, in, ctrl);</li>
<li>full_adder(a, b, ci, s, co)</li>

</ul>

### regfile - top level entity
regfile has a clock , ctrl_writeEnable , ctrl_writeReg, and ctrl_read for both register A and register B, the reg file can read twice as much and write once. we implemented the regfile using 32 registers that consist of 32 dffe that were provided by the instructor
### dffe_ref
this dffe was given by the instructor, and we used it mainly to
create a register. this was done by looping through the dffe_ref

### register
we created 32 registers by looping through the dffe as mentioned above.

### decoder
for the decoder , we made negation loop as the decoder requires
one hot implementaion one wire has bit "1" and the rest should be "0", therefore, we negated the bits of ctrl and used a primitive AND gate with 5 input and one output (the one_hot)
### Shift Arithmetic Right
we used similar approach for shift logical left , that is , we used 5 layers of muxes since the shift amount limit
is 5 bits. this time however, we shift to the right feeding 0's to the left while keeping the sign of the integer
preserved

### triBuff
this was one of the trickiest part in the checkpoint, as for some reason once we had the buffers set they would enumerate
in large amounts. however, this issue was solved with wiring in
similar fashion of a 2-d array and 32'bz

### writing to register
first , we set r0 to be 0 always by setting its ctrl_reset = 1'b1, since this register should hold value 0 always. we then loop through the registers with an AND gate passing in one_hot and ctrl_writeEnable. this will allow us to write to the right information to the intended registers .

### reading from a register
we used the triBuff to loop through each register so that we can conncet them properly to the buffers. this way we can have on register from the 32 registers to read from. 
