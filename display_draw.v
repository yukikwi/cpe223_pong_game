`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 07:09:14 PM
// Design Name: 
// Module Name: display_draw
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


module display_draw(
    input start_x,
    input start_y,
    input x,
    input y,
    output display

    );
    wire [3:0] display_DRAW;
    char_d DRAW_d(start_x, start_y, x, y, display_DRAW[0]);
    char_r DRAW_r(start_x + 31, start_y, x, y, display_DRAW[1]);
    char_a DRAW_a(start_x + 62, start_y, x, y, display_DRAW[2]);
    char_w DRAW_w(start_x + 93, start_y, x, y, display_DRAW[3]);
    assign display = |display_DRAW;
endmodule
