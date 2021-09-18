//`timescale 1 ns / 100 ps
module modulo_5counter_tb;
	reg clk, reset;
	wire [2:0] out, currState;
	
	modulo_5counter unit(out, clk, reset);
	
	always #10 clk = ~clk; // toggle clock every 10 timescale units
	
	initial begin
		clk <= 0;
		reset <= 1;
		
		$monitor ("T=%0t rstn=%0b out=0x%0h", $time, reset, out); 
		repeat(5) @ (posedge clk);
		
		reset<= 0;
		repeat(20) @ (posedge clk);
		
		$finish;
		
	
	end
	

endmodule
