`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 01:38:33 PM
// Design Name: 
// Module Name: display_set_time
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


module display_set_time (
    input [31:0] max_time,
    input [9:0] x,
    input [9:0] y,
    output display
    );
    wire [6:0] text;
    wire [6:0] first_min, second_min, first_sec, second_sec;
    wire display_sec_first, display_sec_second, display_min;
    reg dot;
    //SET SCORE
    char_s SetScore_s1(199, 140, x, y, text[0]);
    char_e SetScore_e1(230, 140, x, y, text[1]);
    char_t SetScore_t1(261, 140, x, y, text[2]);
    char_t SetScore_t2(323, 140, x, y, text[3]);
    char_i SetScore_i(354, 140, x, y, text[4]);
    char_m SetScore_m(385, 140, x, y, text[5]);
    char_e SetScore_e2(416, 140, x, y, text[6]);
    
    always @(x or y) begin
        if(x >= 302 && x < 307 && ((y >= 250 && y < 255) || (y >= 265 && y < 270)))
            dot = 1;
        else
            dot = 0;
    end
    
    integer min;
    integer sec;
    always @(max_time) begin
        min = max_time / 60;
        sec = max_time % 60;
    end
    
    //time seg
    display_time minuteToSeg(min, first_min, second_min);
    display_time SecondToSeg(sec, first_sec, second_sec);
    
    display_seg Minute(second_min, 266, 240, x, y, display_min);
    display_seg FirstSec(first_sec, 312, 240, x, y, display_sec_first);
    display_seg SecondSec(second_sec, 343, 240, x, y, display_sec_second);
    
    assign display = display_min | display_sec_first | display_sec_second | (|text) | dot;
endmodule