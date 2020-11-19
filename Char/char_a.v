`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2020 09:25:54 AM
// Design Name: 
// Module Name: char_a
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


module char_a(
    input [9:0] start_x,
    input [9:0] start_y,
    input [9:0] x,
    input [9:0] y,
    output reg display
    );
    
    initial 
        display = 0;
    always @*
    begin
        if ((x >= start_x + 5) && (x < start_x + 21) && (((y >= start_y) && (y < start_y + 5)) || ((y >= start_y + 19) && (y < start_y + 24))))
            display = 1;
        else if ((y >= start_y + 5) && (y < start_y + 40) && (((x >= start_x) && (x < start_x + 5)) || ((x >= start_x + 21) && (x < start_x + 26))))
            display = 1;
        else display = 0;
    end
endmodule
