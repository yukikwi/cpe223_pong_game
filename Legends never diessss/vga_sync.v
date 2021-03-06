`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 01:04:46 PM
// Design Name: 
// Module Name: vga_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_sync(
		input wire clk, reset,
		output wire hsync, vsync, video_on, p_tick,
		output wire [9:0] x, y
	);
	
	// constant declarations for VGA sync parameters
	localparam H_DISPLAY       = 640; // horizontal display area
	localparam H_BACK          =  48; // horizontal left border
	localparam H_FRONT         =  16; // horizontal right border
	localparam H_RETRACE       =  96; // horizontal retrace
	localparam H_MAX           = H_DISPLAY + H_BACK + H_FRONT + H_RETRACE - 1;
	localparam START_H_RETRACE = H_DISPLAY + H_FRONT;
	localparam END_H_RETRACE   = H_DISPLAY + H_FRONT + H_RETRACE;
	
	localparam V_DISPLAY       = 480; // vertical display area
	localparam V_FRONT         =  10; // vertical top border
	localparam V_BACK          =  33; // vertical bottom border
	localparam V_RETRACE       =   2; // vertical retrace
	localparam V_MAX           = V_DISPLAY + V_FRONT + V_BACK + V_RETRACE -1;
    localparam START_V_RETRACE = V_DISPLAY + V_FRONT;
	localparam END_V_RETRACE   = V_DISPLAY + V_FRONT + V_RETRACE - 1;
	
	// mod-4 counter to generate 25 MHz pixel tick
	reg [15:0] pixel_reg;
	//wire [1:0] pixel_next;
	reg pixel_tick;
	
	always @(posedge clk) {pixel_tick, pixel_reg} <= pixel_reg + 16'h4000;  // divide by 4: (2^16) / 4 = 0x4000
	
	// registers to keep track of current pixel location
	reg [9:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
	
	// register to keep track of vsync and hsync signal states
	reg vsync_reg, hsync_reg;
	wire vsync_next, hsync_next;
 
	// infer registers
	always @(posedge clk, posedge reset)
		if(reset)
		    begin
                    v_count_reg <= 0;
                    h_count_reg <= 0;
                    vsync_reg   <= 0;
                    hsync_reg   <= 0;
		    end
		else
		    begin
                    v_count_reg <= v_count_next;
                    h_count_reg <= h_count_next;
                    vsync_reg   <= vsync_next;
                    hsync_reg   <= hsync_next;
		    end
			
	// next-state logic of horizontal vertical sync counters
	always @*
		begin
		h_count_next = pixel_tick ? 
		               h_count_reg == H_MAX ? 0 : h_count_reg + 1
			       : h_count_reg;
		
		v_count_next = pixel_tick && h_count_reg == H_MAX ? 
		               (v_count_reg == V_MAX ? 0 : v_count_reg + 1) 
			       : v_count_reg;
		end
		
        // hsync and vsync are active low signals
        // hsync signal asserted during horizontal retrace
        assign hsync_next = ~(h_count_reg >= START_H_RETRACE
                            && h_count_reg <= END_H_RETRACE);
   
        // vsync signal asserted during vertical retrace
        assign vsync_next = ~(v_count_reg >= START_V_RETRACE 
                            && v_count_reg <= END_V_RETRACE);

        // video only on when pixels are in both horizontal and vertical display region
        assign video_on = (h_count_reg < H_DISPLAY) 
                          && (v_count_reg < V_DISPLAY);

        // output signals
        assign hsync  = hsync_reg;
        assign vsync  = vsync_reg;
        assign x      = h_count_reg;
        assign y      = v_count_reg;
        assign p_tick = pixel_tick;
 endmodule