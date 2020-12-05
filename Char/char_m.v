`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2020 02:59:22 PM
// Design Name: 
// Module Name: char_m
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


module char_m(
    input [31:0] start_x,
    input [31:0] start_y,
    input [9:0] x,
    input [9:0] y,
    output reg display
    );
    
    initial 
        display = 0;
    always @(x or y)
    begin
        //up and down
        if ((((x >= start_x + 5) && (x < start_x + 10)) || ((x >= start_x + 16) && (x < start_x + 21))) && (((y >= start_y + 5) && (y < start_y + 10))))
            display = 1;
        //left and right
        else if ((((y >= start_y) && (y < start_y + 40))) && (((x >= start_x) && (x < start_x + 5)) || ((x >= start_x + 21) && (x < start_x + 26))))
            display = 1;
        else if ((y >= start_y + 10) && (y < start_y + 15) && ((x >= start_x + 10) && (x < start_x + 16)))
            display =1;
        else display = 0;
    end
endmodule
