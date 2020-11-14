`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2020 07:08:05 PM
// Design Name: 
// Module Name: score
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


module score(
    input [1:0] JB,
    input clk,
    output [4:0] led,
    output [1:0] debugled
    );
    wire [1:0] controller1;
    wire clk_out;
    wire clk_out2;
    //init
    divide delay_input(clk, clk_out);
    divide2 delay_input2(clk, clk_out_2);
    setscore setmaxscore(~JB[0], ~JB[1], clk_out_2, led);
    
    assign debugled = controller1;
endmodule
