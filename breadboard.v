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
    output up, down
    );
    
    assign up = pmod[0];
    assign down = pmod[1];
endmodule
