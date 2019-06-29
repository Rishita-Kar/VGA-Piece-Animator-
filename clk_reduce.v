`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:08:13 11/30/2017 
// Design Name: 
// Module Name:    clk_reduce 
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

// here we have created the 25mhz clock signal that we need for the vga display


//////////////////////////////////////////////////////////////////////////////////
module clk_reduce(
	input master_clk, // input 100mHz
	output wire VGA_clk, //output 25mHz
	input wire reset
);

	
reg [17:0] counter;

	always@(posedge master_clk)
	begin
		
		if (reset == 1'b1| counter == 18'b111111111111111111)
		counter <= 18'b000000000000000000;
		//We use a 100 MHz clock and reduce it by half with every clock signal
		//the counter keeps track and gives us the clock signal we use for our project
		else 
		counter <= counter + 1'b1;
		
	end

assign VGA_clk = (counter[1]); // the 2nd least most sig. bit helps find the 25mHz clock signal


endmodule
