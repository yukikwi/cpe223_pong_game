`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 05:21:34 PM
// Design Name: 
// Module Name: display_setscore
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


module display_setscore(
    input [4:0] score,
    input [9:0] x,
    input [9:0] y,
    output display
    );
    wire [7:0] text;
    wire [6:0] first, second;
    wire display_first, display_second;
    //SET SCORE
    char_s SetScore_s1(183, 140, x, y, text[0]);
    char_e SetScore_e1(214, 140, x, y, text[1]);
    char_t SetScore_t(245, 140, x, y, text[2]);
    char_s SetScore_s2(307, 140, x, y, text[3]);
    char_c SetScore_c(338, 140, x, y, text[4]);
    char_O SetScore_o(369, 140, x, y, text[5]);
    char_r SetScore_r(400, 140, x, y, text[6]);
    char_e SetScore_e2(431, 140, x, y, text[7]);
    
    //score seg
    display_score ScoreToSeg(score, first, second );
    
    display_seg FirstScore(fisrt, 291, 240, x, y, display_first);
    display_seg SecondScore(second, 291 + 31, 240, x, y, display_second);
    
    assign display = display_first | display_second | (|text);
    
endmodule
