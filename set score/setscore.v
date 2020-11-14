`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 07:08:45 PM
// Design Name: 
// Module Name: setscore
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


module setscore(
    input plus, min, clk,
    output reg [5:0] score
    );
    initial
        score = 0;
        
    always @ (posedge clk)
    begin
        if(score <= 20) //set max score to 20
            if(~plus)
                score = score + 1;
        if(score > 0)
            if(~min)
                score = score - 1;
    end
endmodule
