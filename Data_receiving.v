`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:42 12/06/2017 
// Design Name: 
// Module Name:    Data_receiving 
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
module Data_receiving(
	input wire k_clock,
	input wire k_data,
	input wire reset,
	output wire [7:0]data_out_ram
	
    );
	 
	 reg [32:0] sreg; 
	 
	 always@(negedge k_clock or  posedge reset )begin
	 if(reset)
		sreg = 33'b0;
	 else begin
			sreg = sreg << 1;
			sreg[0] = k_data; //single bit data from keyboard
		end
			//wire the corresponding bits to data_out_ram
	 
	 //when you are trying to change the reg then it has to be a reg in a always statement
	 end
	 
//	 data_out_ram[7:0] = sreg[24:31]
			
			/*assign data_out_ram[0] = sreg[31]; 
			assign data_out_ram[1] = sreg[30];
			assign data_out_ram[2] = sreg[29];
			assign data_out_ram[3] = sreg[28];
			assign data_out_ram[4] = sreg[27];
			assign data_out_ram[5] = sreg[26];
			assign data_out_ram[6] = sreg[25];
			assign data_out_ram[7] = sreg[24];		// only assigning an individual bit to a wire. 
			*/


endmodule

