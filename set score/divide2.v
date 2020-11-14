`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 10:45:03 AM
// Design Name: 
// Module Name: divide
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


module divide2(
    input clock,
    output clk_out
    );
    reg elapsed;
    reg elapsed2;
    reg [27:0] state;
     
    always @(posedge clock)
        if (state == 50000000) 
            state <= 0;
        else
            state <= state+1;
    always @(state)
        if (state == 50000000) elapsed = 1;
        else elapsed = 0;
    assign clk_out = elapsed;
endmodule
