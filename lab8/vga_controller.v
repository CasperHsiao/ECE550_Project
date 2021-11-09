module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data, up, down, left, right);

	
input iRST_n;
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
//reg [18:0] ADDR_final;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index;
reg[7:0] index2;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
	  
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here
	
//////Color table output
img_index	img_index_inst (

	.address ( index2 ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////
//////latch valid data at falling edge;
always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;
assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end


//
input up, down, left, right;
reg[18:0] block_addr;
wire base_addr = 19'b0;
integer length = 640; 
integer i;
reg[18:0] x;                           //starting point
reg[18:0] y;
wire[18:0] x_address;									//x, y currently
wire[18:0] y_address;
assign x_address = ADDR % 640;            //final_addr or addr
assign y_address = ADDR / 480;
reg[18:0] ADDR2;
reg[30:0] count;
	
	
	initial
	begin
		x <= 19'b0;
		y <= 19'b0;
		count =0;
		
	end
	//controlling the block
	always@(posedge iVGA_CLK) begin		
			if(((x_address - x) < 31) && ((x_address - x) > 0) && (y_address - y) < 31 && ((y_address - y) > 0)) begin 
				index2 <= 2'b10;
			end
			else begin
				index2 <= index;		
			end
	end
	

	always@(posedge VGA_CLK_n) begin	
		count=count+1;
			if(count%200000==0&& (right == 0)) begin 
				//ADDR2 <= ADDR + 19'b1;
				x <= x + 1;
			end
			else if(count%200000==0&& (left == 0)) begin
				//ADDR2 <= ADDR - 19'b1;
				x <= x - 1;
			end
			else if(count%200000==0&& (up == 0)) begin
				//ADDR2 <= ADDR - 19'd640;
				y <= y - 1;
			end
			else if(count%200000==0&& (down == 0)) begin
				//ADDR2 <= ADDR + 19'd640;
				y <= y + 1;
			end
	end

endmodule
 	















