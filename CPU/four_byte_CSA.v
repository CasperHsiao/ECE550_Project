module four_byte_CSA(a, b, ci, s);
	input [31:0] a, b;
	input ci;
	
	output [31:0] s;
	//output co, overflow;
	
	wire [2:0] c0, c1;
	wire [7:0] s20,s21,s30,s31,s40,s41;
	wire [2:0] sel;
	wire OF0, OF1;
	
	// Compute the 7-0 bits sum with ci input
	byte_RCA adder1(a[7:0],b[7:0], ci,s[7:0],sel[0]);
	// Compute the 15-8 bits sum with carry in 0 and 1
	byte_RCA adder20(a[15:8],b[15:8],1'b0,s20,c0[0]);
	byte_RCA adder21(a[15:8],b[15:8],1'b1,s21,c1[0]);
	// Compute the 23-16 bits sum with carry in 0 and 1
	byte_RCA adder30(a[23:16],b[23:16],1'b0,s30,c0[1]);
	byte_RCA adder31(a[23:16],b[23:16],1'b1,s31,c1[1]);
	// Compute the 31-24 bits sum with carry in 0 and 1
	byte_RCA_last adder40(a[31:24],b[31:24],1'b0,s40,c0[2],OF0);
	byte_RCA_last adder41(a[31:24],b[31:24],1'b1,s41,c1[2], OF1);
	
	// Select the 15-8 bits sum and carry out
	assign s[15:8] = sel[0] ? s21 : s20;
	assign sel[1] = sel[0] ? c1[0] : c0[0];
	// Select the 23-16 bits sum and carry out
	assign s[23:16] = sel[1] ? s31 : s30;
	assign sel[2] = sel[1] ? c1[1] : c0[1];
	// Select the 31-24 bits sum, carry out and overflow
	assign s[31:24] = sel[2] ? s41 : s40;
	//assign co = sel[2] ? c1[2] : c0[2];
	//assign overflow = sel[2] ? OF1 : OF0;
	
endmodule
