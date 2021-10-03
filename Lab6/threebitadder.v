module threebitadder(a, b, cin, HEX1, HEX0);
    input [2:0]a,b;
    input cin;
    output [0:6] HEX1,HEX0;

    reg [3:0]sum, cout,sum1;
	 
always@(*) begin
 
    cout <= (a+b+cin)/10;
    sum <= (a + b + cin) % 10;


end
    sevensegment sevensegment0(sum,HEX0);
    sevensegment sevensegment1(cout,HEX1);

endmodule
