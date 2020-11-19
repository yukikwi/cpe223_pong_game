`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2020 15:35:41
// Design Name: 
// Module Name: char_h
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


module char_n(
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
    
        if((x >= start_x + 5) && (x < start_x + 13)
        && ((y >= start_y + 14) && (y < start_y + 19))) 
            display = 1;
        else if((x >= start_x + 14) && (x < start_x + 21)
        && ((y >= start_y + 20) && (y < start_y + 25))) 
            display = 1;
        else if((y >= start_y) && (y < start_y + 40)
        && ((x >= start_x) && (x < start_x + 5))) 
            display = 1;
        else if((x >= start_x + 21) && (x < start_x + 26)
        && ((y >= start_y) && (y < start_y + 40))) 
            display = 1;
        else display = 0;
    end
endmodule
