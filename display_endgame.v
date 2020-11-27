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
        input  who_win,
        input [9:0] start_x,
        input [9:0] start_y,
        input [9:0] x,
        input [9:0] y,
        output display_player,
        output display_win
    );
    reg [6:0] to_seg;
    wire [2:0] win;
    wire [1:0] player;
    always @(who_win)
    begin
        case(who_win)
            1: to_seg = 7'b1111001;
            2: to_seg = 7'b0100100;
            default: to_seg = 7'b1111001;
        endcase
        
    end
    //display END
    char_p P1_p(start_x , start_y , x , y , player[0]);
    display_seg number_winner(to_seg , start_x + 31 , start_y , x , y , player[1]);
    char_w win_w(start_x + 93 , start_y , x , y , win[0]);
    char_i win_i(start_x + 124 , start_y , x , y , win[1]);
    char_n win_n(start_x + 155 , start_y , x , y , win[2]);
    
    assign display_win = (|win);
    assign display_player = (|player);
endmodule
