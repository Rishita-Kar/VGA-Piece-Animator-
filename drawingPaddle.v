`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:45:09 12/01/2017 
// Design Name: 
// Module Name:    drawingPaddle 
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
module drawingBorder(
	input VGA_clk,
	output wire red,
	output wire green,
	output wire blue
	//output 
    );
	 
	 
	reg border;
	
	always @(posedge VGA_clk)	// 
	begin
	//border <= (((xCount >= 0) && (xCount < 16) || (xCount >= 625) && (xCount < 671)) || ((yCount >= 0) && (yCount < 31) || (yCount >= 465) && (yCount < 496))); 
	border <= (xCount >= 100) && (xCount < 175);
	end
	
	assign red =  ~border;
	assign green = (border);
	assign blue =  border;
	
	
endmodule
