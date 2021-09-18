module modulo_5counter(out, clk, reset);
	output out;
	input clk , reset;
	reg [2:0] out;
	reg [2:0] currState;

	always@(posedge clk) begin
		if(reset) begin // reset = true
			out <= 1'b0;
			currState <= 3'b000;
		end 
		else if(currState > 3'b100) begin
			currState <= 3'b000;
			out <= 1'b0;
		end
		else if(currState == 3'b100) begin
			currState <= 3'b000;
			out <= 1'b1;
		end
		else begin
			currState <= currState + 3'b001;
			out <= 1'b0;
		end
			
		
//		else begin
//			if(currSate > 3'b100) begin
//				currState <= 3'b000;
//				out <= 0;
//			end else if(currState == 3'b100) begin
//				currState <= 3'b000;
//				out <= 1;
//			end else begin
//				currState <= currState + 1;
//				out <= 0;
//			end
//		end
	end
	
	
	
	
	
	
	
	
	
	
//	Output assigned
//	if(currState != 3'b100) begin 
//		assign z = 1'b0;
//	end else begin
//		assign z = 1'b1;
//	end
//	
//	// Assigning next state
//	if(currState < 3'b100)begin
//		assign nexState = currrState + w;
//	end else if(currState > 3'b100) begin
//		assign nexState = 3'b000;
//	end else begin
//		if(w == 0) begin
//			nexState = currState;
//		end else begin
//			nexState = 3'b000;
//		end
//	end
	
endmodule
