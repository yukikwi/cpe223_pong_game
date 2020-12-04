`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 01:44:06 PM
// Design Name: 
// Module Name: counter_time_1
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


module counter_time_1(
    input clk_in,
    input [7:0] max_time,
    input reset,
    output [3:0] A,
    output [3:0] B,
    output [3:0] C
    );
    
    wire [7:0] display_time;
    reg [7:0] present_time;
    
    initial present_time = 8'h0;
    
    always @(posedge clk_in)
    begin
        if(reset || present_time == 8'hb4)
        begin
            present_time = 8'b0;
        end
        else 
        begin
            present_time = present_time + 1;
        end
    end
    
    assign display_time = max_time - present_time;
    assign A = display_time/60;
    assign B = (display_time % 60)/10;
    assign C = (display_time % 60)%10; 
endmodule
