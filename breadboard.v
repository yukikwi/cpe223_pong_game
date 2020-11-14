`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 01:37:29 PM
// Design Name: 
// Module Name: breadboard
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


module breadboard(
    input [1:0] pmod,
    input clk,
    output reg [1:0] out
    );
    
    always @ (posedge clk)
    begin
        if(pmod[0])
            out[0] <= 0;
        else
            out[0] <= 1;
            
        if(pmod[1])
            out[1] <= 0;
        else
            out[1] <= 1;
    end
    
endmodule
