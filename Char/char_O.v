`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 07:41:15 PM
// Design Name: 
// Module Name: char_O
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


module char_O(
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
        if((x >= start_x + 5) && (x < start_x + 21) 
        && (((y >= start_y) && (y < start_y + 5)) || ((y >= start_y + 35) && (y < start_y + 40))))
            display = 1;
        //left and right
        else if((y >= start_y + 5) && (y < start_y + 35) 
        && (((x >= start_x) && (x < start_x + 5)) || ((x >= start_x + 21) && (x < start_x + 26)))) 
            display = 1;
        else display = 0;
    end
        
endmodule
