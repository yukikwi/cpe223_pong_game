`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2020 09:58:12 AM
// Design Name: 
// Module Name: display_endgame
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


module display_endgame(
        input [9:0] start_x,
        input [9:0] start_y,
        input [9:0] x,
        input [9:0] y,
        output display
    );
    wire [2:0] display_End;
    //display END
    char_e End_e(start_x , start_y , x , y , display_End[0]);
    char_n End_n(start_x + 31 , start_y , x , y , display_End[1]);
    char_d End_d(start_x + 62 , start_y , x , y , display_End[2]);
    
    assign display = (|display_End);
endmodule
