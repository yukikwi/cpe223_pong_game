`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 05:11:04 PM
// Design Name: 
// Module Name: counter_p1
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


module counter(
    input clk,
    input reset,
    output [4:0] score
    );
    
    reg [4:0]score_tmp = 0;
    
    always @(posedge clk or posedge reset)
    begin
        if(score_tmp == 32 || reset)
            score_tmp = 0;
        else
            score_tmp = score_tmp + 1;
    end
    
    assign score = score_tmp;
endmodule
