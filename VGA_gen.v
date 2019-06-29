`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:32 11/30/2017 
// Design Name: 
// Module Name:    VGA_gen 
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
module VGA_gen
(
	input VGA_clk, 
	output reg [9:0] xCount, 
	output reg [9:0] yCount, 
	output reg displayArea, 
	output VGA_hSync, 
	output VGA_vSync, 
	output blank_n
 );

	reg complete_h_retrace, complete_v_retrace; 
	
	integer porchHF = 640; //start of horizntal front porch
	integer retraceH = 655;//start of horizontal sync
	integer porchHB = 751; //start of horizontal back porch
	integer maxH = 799; //setting max length of horizontal 

	integer porchVF = 480; //start of vertical front porch 
	integer retraceV = 490; //start of vertical sync
	integer porchVB = 492; //start of vertical back porch
	integer maxV = 525; //setting max length of vertical 
/////////////////////////////////////////////////////////////////////////////////////

	always@(posedge VGA_clk) // VGA_CLK = 25 mHz
	begin
		if(xCount === maxH) //Here we are starting back to the start of the FULL DISPLAY. 
			xCount <= 0;
		else
			xCount <= xCount + 1;  // goes through the horizontal axis by traversing and triggering each pixel until we complete triggering all of our ACTIVE DISPLAY region;
										  //0-799 which is a total of 800 pixels (size of Horizontal-ACTIVE DISPLAY)
	end
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	always@(posedge VGA_clk)
	begin
		if(xCount === maxH)
		begin
		// Here we are starting the vertical movement of the printing.
			if(yCount === maxV)
				yCount <= 0; //Once it has traveled top to bottom we reset back to 0. 0 for us means TOP of FULL dispay and 525 means the bottom of FULL DISPLAY
			else
			yCount <= yCount + 1; // traverses and triggers through every pixel of the vertical row until we complete triggering all of our ACTIVE DISPLAY region
										 // 0-479 which is a total of 480 pixels (size of Vertical-ACTIVE DISPLAY)
		end
	end
	
	always@(posedge VGA_clk)
	begin
		displayArea <= ((xCount < porchHF) && (yCount < porchVF)); // As long as we are before pixels 639, on the Horizontal direction(end of our Horizontal-Active Display)
																					  //and we have reached the last row, 479, on the vertical direction(end of our Vertical-Active Display) 
																					  //then we use boolean logic to constrain our active displayArea to the above conditions
	end

	always@(posedge VGA_clk)
	begin
		complete_h_retrace <= ((xCount >= retraceH) && (xCount < porchHB)); // defining the retrace period, for horizontal direction, so that we know when to maintain the pixels off.
		complete_v_retrace <= ((yCount >= retraceV) && (yCount < porchVB)); // defining the retrace period, for the vertical direction, so that we know when to maintain pixels off.
	end
 
	assign VGA_vSync = ~complete_v_retrace; // 1 becomes 0 //because if you look at the behavior of the h_sync, 0 is meant for off
	assign VGA_hSync = ~complete_h_retrace; // 1 becomes 0 // because if you look at the behavior of the v_sync, 0 is meant for off
	assign blank_n = displayArea;  
endmodule		
