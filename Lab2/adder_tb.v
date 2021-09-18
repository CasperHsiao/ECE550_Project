
`timescale 1 ns / 100 ps
module adder_tb();
	reg [3:0]a;
	reg [3:0]b;
	reg ci;
	
	reg clock;
	
	wire [3:0]sum;
	wire co;
	
	adder test_adder (a, b, ci, sum, co);
	
	integer num_errors;

 	// begin simulation
 	initial begin
       	$display($time, " simulation start");
       	
       	clock = 1'b0;
			num_errors = 0;
       	
       	@(negedge clock); // wait for the clock to go negative
       	a = 4'b0011;
			b = 4'b0100;
			ci = 1'b0;
       	
       	@(negedge clock);
       	if (sum != 4'b0111) begin
            	$display("Expected 7 got %b", sum);
            	num_errors = num_errors + 1;
       	end
			
			@(negedge clock); // wait for the clock to go negative
       	a = 4'b0001;
			b = 4'b0100;
			ci = 1'b0;
       	
       	@(negedge clock);
       	if (sum != 4'b0101) begin
            	$display("Expected 5 got %b", sum);
            	num_errors = num_errors + 1;
       	end
       	
       	
       	
       	if (num_errors == 0) begin
            	$display("Simulation succeeded with no errors.");
       	end else begin
            	$display("Simulation failed with %d error(s).", num_errors);
       	end
 	end
 	
 	always
       	#10 clock = ~clock; // toggle clock every 10 timescale units
	
endmodule
