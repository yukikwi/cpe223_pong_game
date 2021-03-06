`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2020 01:37:22 PM
// Design Name: 
// Module Name: time_display
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


module time_display(
    input orig_clk,
    input [7:0]max_time,
    input time_en,
    input reset,
    output wire time_out,
    output [6:0] seg,
    output reg [3:0] an
    );
    
//    reg [7:0]display_time;
    wire [3:0]A, B, C; 
    wire [3:0] mux_to_bcd;
    wire clk_out_di_switch;
    
    reg [1:0]selector = 0;
    
    divider_1Hz divt (orig_clk & time_en, clk);
    
    counter_time_1 count_1 (clk, max_time, reset, A, B, C, time_out);
    mux12_to_4 mux12 (A, B, C, selector, mux_to_bcd);
    bcdto7seg bcd_to7seg (mux_to_bcd,seg);
    divide_switch switching (orig_clk,clk_out_di_switch);
    
    always @(posedge clk_out_di_switch)
    begin 
        case (selector)
            0:
                begin
                    an = 4'b1101;
                    selector = 1;
                end
            1:
                begin
                    an = 4'b1110;
                    selector = 2;
                end
            2:
                begin
                    an = 4'b1011;
                    selector = 0;
                end
            default:
                begin
                    an = 4'b1101;
                    selector = 1; 
                end
        endcase 
     end
endmodule
