# ECE550 Project Checkpoint 1
**Team members:** Casper Hsiao (ph139) and Hussain Alkhateeb (hma23)

## Checkpoint Summary
This checkpoint delivers an ALU unit in Verilog that computes addition and subtraction of two 32-bits integer.

## Design Implementation
**Modules:**
<ul>
<li>alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow)</li>
<li> four_byte_CSA(a, b, ci, s, co, overflow)</li>
<li>mux_2_1(a , b, sel, out)</li>
<li>byte_RCA(a, b, ci, s, co)</li>
<li>byte_RCA_last(a, b, ci, s, co, overflow)</li>
<li>full_adder(a, b, ci, s, co)</li>
</ul>

**alu module - top level entity:** Implemented the addition and subtraction functions using the `four_byte_CSA` module. First, we negated the `data_operand_B` and used the `mux_2_1` with the `ctrl_ALUopcode` to select the correct operand for our `four_byte_CSA`. Then, we used the `ctrl_ALUopcode` as the carry in of the `four_byte_CSA` to compute either the addition or subtraction.

**four_byte_CSA:** Implemented the 32 bits carry select adder using four 8 bits ripple carry adder, `byte_RCA`. The last 8 bits (31:24) computation uses the `byte_RCA_last` to obtain the overflow of the overall computation.

**byte_RCA** and **byte_RCA_last:** Implemented 8 bits ripple carry adder by using 8 full adders, `full_adder`. The difference between `byte_RCA` and `byte_RCA_last` is that the later have an extra output that determines if overflow occured.

**full_adder:** Implemented the full adder at the gate level.

## Reflection
We ran our code and tested it using the waveform for edge cases and cases that we thought our implementation might fail. We then made sure our timing is roughly correct. And then, we used the test bench that was provided by instructor to run. We had issues with special case like 0h80000000 for subtraction. However, we found it that having the carrying in to do the two’s complement instead of doing it later will solve the issue. our worst timing now is 24 nanoseconds, we think that we can reduce our time by factoring the CSA more (I.e. more layers of CSA). 
