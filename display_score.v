`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2020 06:25:34 PM
// Design Name: 
// Module Name: display_score
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


module display_score(
    input [5:0] score,
    output reg [6:0] display_first,
    output reg [6:0] display_second
    );
    initial begin
        display_first = 7'b1111111;
        display_second = 7'b1111111;
    end
    
    integer first;
    integer second;
    always @(score)
    begin
    first = score / 10;
    second = score % 10;
        case(first)
            0 : display_first = 7'b1000000;
            1 : display_first = 7'b1111001;
            2 : display_first = 7'b0100100;
            3 : display_first = 7'b0110000;
            4 : display_first = 7'b0011001;
            5 : display_first = 7'b0010010;
            6 : display_first = 7'b0000010;
            7 : display_first = 7'b1111000;
            8 : display_first = 7'b0000000;
            9 : display_first = 7'b0010000;
            endcase
            
        case(second)
            0 : display_second = 7'b1000000;
            1 : display_second = 7'b1111001;
            2 : display_second = 7'b0100100;
            3 : display_second = 7'b0110000;
            4 : display_second = 7'b0011001;
            5 : display_second = 7'b0010010;
            6 : display_second = 7'b0000010;
            7 : display_second = 7'b1111000;
            8 : display_second = 7'b0000000;
            9 : display_second = 7'b0010000;
        endcase
    end
endmodule
