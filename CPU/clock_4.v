module clock_4 (clock_in,reset, clock_out);
	input clock_in;
	input reset;
	output clock_out;
	
	reg [1:0] register;
	wire [1:0] next;
	reg clock_track;
	 
	always @(posedge clock_in or posedge reset)
	 
	begin
	  if (reset)
		 begin
			register <= 2'b00;
			clock_track <= 1'b0;
		 end
	 
	  else if (next == 2'b10)
		   begin
			 register <= 2'b00;
			 clock_track <= ~clock_track;
		   end
	 
	  else 
		  register <= next;
	end
	 
	assign next = register + 2'b01;   	      
	assign clock_out = clock_track;
endmodule
