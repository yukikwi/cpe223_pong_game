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
    output display
    );
    reg [6:0] display_temp;
    initial
    begin   
        display_temp = 7'b0;
    end
    always @*
    begin
        if(~seg[0])
            begin
                if((x >= (start_x + 5) && x < (start_x + 21)) && (y >= start_y && y < (start_y + 5))) 
                    display_temp[0] = 1;
                else display_temp[0] = 0;
            end
        if(~seg[1])
            begin
                if(((x >= start_x + 21) && x < (start_x + 26)) && (y >= (start_y + 5) && y < (start_y + 17)))
                    display_temp[1] = 1;
                else display_temp[1] = 0;
            end
        if(~seg[2])
            begin
                if(((x >= start_x + 21) && x < (start_x + 26)) && (y >= (start_y + 22) && y < (start_y + 34)))
                    display_temp[2] = 1;
                else display_temp[2] = 0;
            end
        if(~seg[3])
            begin
                if((x >= (start_x + 5) && x < (start_x + 21)) && (y >= (start_y + 34) && y < (start_y + 39)))
                    display_temp[3] = 1;
                else display_temp[3] = 0;
            end
        if(~seg[4])
            begin
                if((x >= start_x && x < (start_x + 5)) && (y >= (start_y + 22) && y < (start_y + 34)))
                    display_temp[4] = 1;
                else display_temp[4] = 0;
            end
        if(~seg[5])
            begin
                if((x >= start_x && x < (start_x + 5)) && (y >= (start_y + 5) && y < (start_y + 17)))
                    display_temp[5] = 1;
                else display_temp[5] = 0;
            end
        if(~seg[6])
            begin
                if((x >= (start_x + 5) && x < (start_x + 21)) && (y >= (start_y + 17) && y < (start_y + 22)))
                    display_temp[6] = 1;
                else display_temp[6] = 0;
            end
    end
   assign display = (display_temp[0] | display_temp[1] | display_temp[2] |display_temp[3] | display_temp[4] | display_temp[5] | display_temp[6]);
endmodule
