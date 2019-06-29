`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:11:56 11/30/2017 
// Design Name: 
// Module Name:    topmod 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
/*module topmod( input wire clk, input wire reset,
output wire VGA_clk

    );

clk_reduce A(master_clk,VGA_clk);



endmodule
*/

module topmod 
(
	input wire reset,
	input wire clk,
	inout k_clk,
	inout k_dat,
	output wire hsync, vsync,
	output wire rgb_r,
	output wire rgb_g,
	output wire rgb_b,
	output reg [7:0]data_in
	//output wire [7:0]data_out_ram
	//output wire [7:0]data_out_ram
	//output reg border0,
	//output reg border1

);

///////////////////////////////////////////////////////////////////
//signal declaration
wire blank_n;
wire clks;
wire [9:0] xCount;
wire [9:0] yCount;
wire digit;
reg [32:0] sreg;
reg border0;
reg border2;
wire draw_bar;
wire temp0;
wire temp2;
/////////////////////////////////////////////////////////////////////////////////




///////////////////////////getting keyboard input ///////////////////////////////////////////////////




always@(negedge k_clk or  posedge reset )begin
	 if(reset)
		sreg = 33'b0;
	 else begin
			sreg = sreg << 1;
			sreg[0] = k_dat; //single bit data from keyboard
		end
		
	 end
			
			
			
			
			
			
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////// NOW WE NEED TO VERFY WHETHER WE HAVE PRESSED UP OR DOWN /////////////////////////////////



		 
	always@(posedge clk) begin
		data_in[7:0] = 8'b00000000;
		if (sreg[31:24] == 8'b10111000) begin
		data_in[0] = sreg[31]; 
		data_in[1] = sreg[30];
		data_in[2] = sreg[29];
		data_in[3] = sreg[28];
		data_in[4] = sreg[27];
		data_in[5] = sreg[26];
		data_in[6] = sreg[25];
		data_in[7] = sreg[24];
		end
		else if (sreg[31:24] == 8'b11011000) begin
		data_in[0] = sreg[31]; 
		data_in[1] = sreg[30];
		data_in[2] = sreg[29];
		data_in[3] = sreg[28];
		data_in[4] = sreg[27];
		data_in[5] = sreg[26];
		data_in[6] = sreg[25];
		data_in[7] = sreg[24];
		end
		
	
	 end



//////////////// creating the WALL AND BALL and setting the colors for  WALL,BALL, and BAR ////////////////////////////////////////////// 
	
	//reg border;
	
	always @(posedge clks) 
	begin
	
	// We use the xCount and yCount which is our x and y coordinates at the time of each pixel trigger
	// We begin to create the Ball and Wall
	border0 <= (xCount >= 100) && (xCount < 175) && (~border2 && ~draw_bar); // WALL //designating the dimesions of our wall
																									 // we have used boolean logic to make sure we only print at the desinated area
	border2 <= 	(((xCount >= 580) && (xCount <588) && (yCount >= 238) && (yCount < 245))) && (~draw_bar &&~border0); //designating the dimesions of our BALL
																									 // we have used boolean logic to make sure we only print at the desinated area
	end


	// designating color to WALL,BALL,AND BAR

	assign rgb_r =  border2;
	assign rgb_g = draw_bar;
	assign rgb_b =  border0;
	
	
	

	assign temp0 = border0;
	assign temp2 = border2;





//instantiate vga sync circuit
clk_reduce A(clk,clks, reset);

// 
VGA_gen B(.VGA_clk(clks),.xCount(xCount),.yCount(yCount),.VGA_hSync(hsync),.VGA_vSync(vsync),.blank_n(blank_n));

BarMovement C(.clk(clk), .clk_25mHz(clks),.reset(reset),.border0(temp0),.border2(temp2),.xCount(xCount),.yCount(yCount),.data_in(data_in),.draw_bar(draw_bar));



endmodule 
