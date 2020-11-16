`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2020 07:16:05 PM
// Design Name: 
// Module Name: display_seg
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


module display_seg(
    input [6:0] seg,
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
        if(~seg[0])
            begin
                if((x >= (start_x + 4) && x <= (start_x + 20)) && (y >= start_y && y <= (start_y + 4)))
                    display = 1;
            end
        if(~seg[1])
            begin
                if(((x >= start_x + 20) && x <= (start_x + 24)) && (y >= (start_y + 4) && y <= (start_y + 16)))
                    display = 1;
            end
        if(~seg[2])
            begin
                if(((x >= start_x + 20) && x <= (start_x + 24)) && (y >= (start_y + 20) && y <= (start_y + 32)))
                    display = 1;
            end
        if(~seg[3])
            begin
                if((x >= (start_x + 4) && x <= (start_x + 20)) && (y >= (start_y + 32) && y <= (start_y + 36)))
                    display = 1;
            end
        if(~seg[4])
            begin
                if((x >= start_x && x <= (start_x + 4)) && (y >= (start_y + 20) && y <= (start_y + 32)))
                    display = 1;
            end
        if(~seg[5])
            begin
                if((x >= start_x && x <= (start_x + 4)) && (y >= (start_y + 4) && y <= (start_y + 16)))
                    display = 1;
            end
        if(~seg[6])
            begin
                if((x >= (start_x + 4) && x <= (start_x + 20)) && (y >= (start_y + 32) && y <= (start_y + 36)))
                    display = 1;
            end
    end
endmodule
