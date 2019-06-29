`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:50:11 12/06/2017 
// Design Name: 
// Module Name:    BarMovement 
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
module BarMovement( 
	input wire clk,
	input wire clk_25mHz,
	input wire reset,
	input wire border0,	//wall
	input wire border2,	// ball
	input wire [9:0] xCount,
	input wire [9:0] yCount,
	input wire [7:0] data_in, // scan code
	output draw_bar
    );
	 
	 reg [7:0] data_out;
	
	always@ (posedge clk) begin
		data_out[7:0] = data_in[7:0];
	end
	
	//////////////////////////////////////////////////////////////
	
	//////////////////////////////////////////////////////////////
	
	integer V_Display = 480; // setting limits for the bottom of the screen 

	//border1 <= ((xCount >= 600) && (xCount < 606) && (yCount >= 204) && (yCount < 276)) &&(~border2 && ~border0); //bar
	integer leftside = 600; // piece's left side
	integer rightside = 606; // piece's right side
	wire [9:0] top; // piece's top barrier
	wire [9:0] bottom; // piece's bottom barrier
	wire border1; // determines if the piece is displayed
	wire redraw_animation; // if the screen has refreshed
	
	
	reg [9:0] currentstate;	//
	reg [9:0] nextstate;	//
	
	
	integer size = 71; // declaring a size for the bar in vertical direction so we maintain same size when we move up or down

	
	integer velocity = 4; // piece's movement speed in the vertical direction 
	
	
	always@ (posedge clk_25mHz, posedge reset) begin
		if (reset) begin
			//projectile_Cstate <= 1'b0;
			currentstate <= 1'b0;
		end
		
		else begin
			//projectile_Cstate <= projectile_Nstate;
			currentstate <= nextstate;
		end
	end
	
	assign top = currentstate; // setting top barrier
	assign bottom = top + size; // setting bottom barrier
	
	assign redraw_animation = (yCount == 481) && (xCount == 0); //&& (pixelY == 0) && (pixelX == 641);
	assign border1 = ((xCount >= leftside) && (xCount < rightside) && (yCount >= top) && (yCount < bottom)) &&(~border2 && ~border0); //draw the border only within these constraints
		
	always@ (posedge clk_25mHz) begin
			//nextstate = currentstate;
			
			if (redraw_animation) begin
				if ((data_out == 8'b00011101) & (bottom < (V_Display - velocity))) begin //|| (controller[1]
					nextstate <= currentstate + velocity;
				end
				
				else if ((data_out == 8'b00011011) & (top > velocity)) begin //|| (controller[0]
					nextstate <= currentstate - velocity;
				end
			end
	end
	
		assign draw_bar = border1;
	
endmodule
