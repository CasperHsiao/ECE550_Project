module WTM_tb;
	// Inputs
	reg [4:0] A,B;
	// Outputs
	wire [9:0] prod;
	
	integer i,j,error;
 // Instantiate the Unit Under Test (UUT)
	//    wallace_tree_multiplier uut (
	//        .A(A), 
	//        .B(B), 
	//        .prod(prod)
	//    );
	wallace_tree_multiplier uut(A, B, prod);

	initial begin
        // Apply inputs for the whole range of A and B (2^5 and 2^5).
        // 32*32 = 1024 inputs.
        error = 0;
        for(i=0;i <=32;i = i+1)
            for(j=0;j <=32;j = j+1) 
            begin
                A <= i; 
                B <= j;
                #1;
                if(prod != A*B) //if the result isnt correct increment "error".
                    error = error + 1;  
            end     
    end
	 
endmodule
