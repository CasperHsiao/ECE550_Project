module wallace_tree_multiplier(A, B, prod);
	input [4:0] A, B;
	output [9:0] prod;
	
	wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20;
	wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20;
	wire [4:0] p0, p1, p2, p3, p4;
	
	// initialize partial products
	// Example: a0b0 = p0[0], a2b3 = p3[2]
	assign p0 = A & {5{B[0]}}; //b0a0 b0a1 b0a2 b0a3 b0a4
	assign p1 = A & {5{B[1]}};
	assign p2 = A & {5{B[2]}};
	assign p3 = A & {5{B[3]}};
	assign p4 = A & {5{B[4]}};
	
	
	// first stage
	full_adder ha11 (p0[1], p1[0], 1'b0, s1, c1); 
	full_adder fa11 (p0[2], p1[1], p2[0], s2, c2);
	full_adder fa12 (p0[3], p1[2], p2[1], s3, c3);
	full_adder fa13 (p0[4], p1[3], p2[2], s4, c4);
	full_adder ha12 (p1[4], p2[3], 1'b0, s5, c5);
	
	//second stage
	full_adder ha21(s2,c1,1'b0,s6,c6);
	full_adder fa21(s3,c2,p3[0],s7,c7);
	full_adder fa22(s4,c3,p3[1],s8,c8);
	full_adder fa23(s5,c4,p3[2],s9,c9);
	full_adder fa24(p2[4],c5,p3[3],s10,c10);
	
	
	//third stage
	full_adder ha31(s7,c6,1'b0,s11,c11);
	full_adder fa31(s8,c7,p4[0],s12,c12);
	full_adder fa32(s9,c8,p4[1],s13,c13);
	full_adder fa33(s10,c9,p4[2],s14,c14);
	full_adder fa34(p3[4],c10,p4[3],s15,c15);
	
	//final stage
	full_adder faf1(s12, c11, 1'b0, s16, c16);
	full_adder faf2(s13, c12, c16, s17, c17);
	full_adder faf3(s14, c13, c17, s18, c18);
	full_adder faf4(s15, c14, c18, s19, c19);
	full_adder faf5(p4[4], c15, c19, s20, c20);
	
	//product
	assign prod[0] = p0[0];
	assign prod[1] = s1;
	assign prod[2] = s6;
	assign prod[3] = s11;
	assign prod[4] = s16;
	assign prod[5] = s17;
	assign prod[6] = s18;
	assign prod[7] = s19;
	assign prod[8] = s20;
	assign prod[9] = c20;
	
	
	
endmodule
