module threebitadder(a, b, c, cin, HEX1, HEX0);
	input [1:0]a,b,c;
	input cin;
	output [0:6] HEX1,HEX0;
	
	reg [4:0]sum,cout;
	reg [4:0] temp1, temp2;

always@(*) begin
 
	cout <= 0;
	sum <= a + b + c+cin;
	if (sum == 5'b11111) begin
		temp1 <= 5'b00000;
		temp2 <= 5'b00001;
	end 
	else begin	
		temp1 <= sum;
		temp2 <= cout;
	end
end
	sevensegment sevensegment2(temp1,HEX0);
	sevensegment sevensegment3(temp2,HEX1);

endmodule
