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
</ul>

### regfile - top level entity
`regfile` has two reading ports, one writing port and stores 32x32-bit data. We implemented the `regfile` data storage using 32 `register`s each consist of 32 `dffe_ref`s. We implemented one-hot wire `decoder` to determine the registers to read and write. We utilized the `triBuff` to select the register to read from.

### dffe_ref
This DFFE was given by the instructor, and we used it to create the `register` module.

### register
We created the 32-bit `register` module by looping through and construct `dffe_ref` 32 times.

### decoder
For the `decoder`, we implemented one-hot wire. We negated the bits of ctrl and used a primitive AND gate with 5 input and one output (the one_hot).

### triBuff
This was one of the trickiest part in the checkpoint, as for some reason once we had the buffers set they would enumerate in large amounts. however, this issue was solved with wiring in similar fashion of a 2-d array and 32'bz

### writing to register
First, we set the first `register` to be 0 always by setting its ctrl_reset = 1'b1, since this register should hold value 0 always. We then loop through the registers with an AND gate passing in one_hot and ctrl_writeEnable. this will allow us to write to the right information to the intended registers.

### reading from a register
We used the triBuff to loop through each register so that we can connect them properly to the buffers. this way we can have on register from the 32 registers to read from. 
