`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 02:25:27 PM
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input [2:0] Ain,
    output [6:0] seg,
    output [3:0] an
    );
    
    wire clk_out;
    
    reg [7:0]max_time = 20;
    reg reset;
    
    time_display(clk, max_time, reset, seg, an);
    
endmodule
