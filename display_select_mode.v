`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 09:34:03 AM
// Design Name: 
// Module Name: select_mode
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


module display_select_mode(
        input [9:0] start_x,
        input [9:0] start_y,
        input [9:0] x,
        input [9:0] y,
        output display
    );
    wire [6:0] display_PongPVP;
    wire [4:0] display_Score;
    wire [3:0] display_Time;
    
    //display "PONG PVP"
    char_p PongPVP_p1(start_x , start_y , x , y , display_PongPVP[0]);
    char_O PongPVP_o(start_x + 31 , start_y , x , y , display_PongPVP[1]);
    char_n PongPVP_n(start_x + 62 , start_y , x , y , display_PongPVP[2]);
    char_g PongPVP_g(start_x + 93 , start_y , x , y , display_PongPVP[3]);
    char_p PongPVP_p2(start_x + 155 , start_y , x , y , display_PongPVP[4]);
    char_v PongPVP_v(start_x + 186 , start_y , x , y , display_PongPVP[5]);
    char_p PongPVP_p3(start_x + 217 , start_y , x , y , display_PongPVP[6]);
    
    //display "SCORE"
    char_s Score_s(start_x + 44 , start_y + 130 , x , y , display_Score[0]);
    char_c Score_c(start_x + 75 , start_y + 130 , x , y , display_Score[1]);
    char_O Score_o(start_x + 106 , start_y + 130 , x , y , display_Score[2]);
    char_r Score_r(start_x + 137 , start_y + 130 , x , y , display_Score[3]);
    char_e Score_e(start_x + 168 , start_y + 130 , x , y , display_Score[4]);
    
    //display "TIME"
    char_t Time_t(start_x + 59 , start_y + 210 , x , y , display_Time[0]);
    char_i Time_i(start_x + 90 , start_y + 210 , x , y , display_Time[1]);
    char_m Time_m(start_x + 121 , start_y + 210 , x , y , display_Time[2]);
    char_e Time_e(start_x + 152 , start_y + 210 , x , y , display_Time[3]);
    
    assign display = |display_PongPVP | |display_Score | |display_Time;
endmodule
