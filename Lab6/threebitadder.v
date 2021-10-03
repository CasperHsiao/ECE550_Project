module threebitadder(
	input [1:0]a,b,c,
	input cin,
	output [0:6] HEX1,HEX0
);
reg [4:0]sum,cout;

always@(*) begin
 
	cout <= 0;
	sum <= a + b + c+cin;
end
	
sevensegment sevensegment0(sum,HEX0);
sevensegment sevensegment1(cout,HEX1);

endmodule
