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
    inout [1:0] pmod,
    input clk,
    output reg [1:0] out
    );
    initial
        out = 2'b11;
    
    reg [1:0] store_pmod = 2'b00;
    always @ (posedge clk)
    begin
        if(pmod[0])
            if(store_pmod[0] == 0)
                begin
                    out[0] = 1;
                    store_pmod[1] = 1;
                end
            else
                begin
                    out[0] = 0;
                    store_pmod[0] = 0;
                end
        else
            out[0] = 1;
            
        if(pmod[1])
            if(store_pmod[1] == 0)
                begin
                    out[1] = 1;
                    store_pmod[1] = 1;
                end
            else
                begin
                    out[1] = 0;
                    store_pmod[1] = 0;
                end
        else
            out[1] = 1;
    end
    
endmodule
