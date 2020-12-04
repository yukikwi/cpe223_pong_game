`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 01:47:12 PM
// Design Name: 
// Module Name: mux12_to_4
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


module mux12_to_4(
    input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [1:0] selector,
    output reg[3:0] out
    );
    
    always @ (selector)
    begin
    case(selector)
        0: out = A;
        1: out = B;
        2: out = C;
        default: out = A;
    endcase 
    end
endmodule