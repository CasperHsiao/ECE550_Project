# Full ALU Implementation - Checkpoint 2
## NetID : hma23 , ph139



## Design Implementation
**Modules:**
<ul>
<li>alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow)</li>
<li> four_byte_CSA(a, b, ci, s, co, overflow)</li>
<li>mux_2_1(a , b, sel, out)</li>
<li>byte_RCA(a, b, ci, s, co)</li>
<li>byte_RCA_last(a, b, ci, s, co, overflow)</li>
<li>full_adder(a, b, ci, s, co)</li>
<li>shiftLL_by_5bit(data_operandA, ctrl_shiftamt, shiftLL_result)</li>
<li>shiftRA_by_5bit(data_operandA, ctrl_shiftamt, shiftLL_result)</li>
</ul>

### ALU - top level entity
We labeled the first three bits of the `ctrl_ALUopcode` by `s2s1s0`, the first bit `s0` selects (ADD | SUB) for arithmetic operations, (AND | OR ) for logic operations, and (Logical Left | Arithmetic Right) for shift operation. Then, we use the second bit `s1` to select between arithmetic operation and logical operation. Lastly, we use the third bit `s2` to select the previous result and shift operation to output `data_result`.

**Arithmetic operation**: Implemented the addition and subtraction functions using the `four_byte_CSA` module. First, we negated the `data_operand_B` and used the `mux_2_1` with the `ctrl_ALUopcode` to select the correct operand for our `four_byte_CSA`. Then, we used the `ctrl_ALUopcode` as the carry in of the `four_byte_CSA` to compute either the addition or subtraction.

### Logic bitwise AND
we implemented bitwise AND by looping through each bit in operandA anding it with operandB , using the genvar loop, we then
store the value in data_result.

### Logic bitwise OR
we implemented bitwise OR by looping through each bit in operandA oring it with operandB , using the genvar loop, we then
store the value in data_result.

### Shift Logical Left
Our Implementation followed the slides that were given by the instructor. we used 5 layers of muxes since the shift amount
limit is 5 bits. this will allow us to shift to the desired amount feeding 0's to the right of the number because each layer
of muxes is connected to the previous one ,and the first layer is connected with a zero

### Shift Arithmetic Right
we used similar approach for shift logical left , that is , we used 5 layers of muxes since the shift amount limit
is 5 bits. this time however, we shift to the right feeding 0's to the left while keeping the sign of the integer
preserved

### Less Than
To check if A is strictly less than B , we had to check our results after subtraction, we then extract the last
bit of the our result. If our result is negative (last bit = 1) we know A is less than B, otherwise , B is greater
than or equal to A

### Not equal
we used our bitwise OR loop to through each bit with the next bit of our arithmetic result, leaving us with 31 bit as result
of the loop we then assign the last bit of the or result to the result of not equal (if the last bit of or loop is 1) then,
A is not equal to B. because there was at least one bit that is 1 and therefore, our arithmetic result doesn't equal to zero

### four_byte_CSA:
Implemented the 32 bits carry select adder using four 8 bits ripple carry adder, `byte_RCA`. The last 8 bits (31:24) computation uses the `byte_RCA_last` to obtain the overflow of the overall computation.

### byte_RCA and byte_RCA_last:
Implemented 8 bits ripple carry adder by using 8 full adders, `full_adder`. The difference between `byte_RCA` and `byte_RCA_last` is that the later have an extra output that determines if overflow occured.

### full_adder:
Implemented the full adder at the gate level.
