# Full Alu Implementation - Checkpoint 2
## NetID : hma23 , Casper's ID

#### ALU opcode
    we divided the operations to three units by looking to each bit in each column , the first column represent arithmetic operations (ADD / SUB),
    then , the second one is logic operations (AND / OR ), finally we had the shift operation (Logical Left / Arithmetic Right)
    and then we use a mux to choose between each operation in a unit.

#### Logic bitwise AND
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
