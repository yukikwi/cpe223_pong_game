`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 11:28:19 AM
// Design Name: 
// Module Name: set_scores
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


module set_scores(
    input add,
    input sub,
    output [4:0] display
    );
    reg [4:0]tmp = 5'b00001;
    wire addsub = add | sub;
    
    always @ (posedge addsub)
    begin
        if(add)
            if (tmp < 5'b10100)
                tmp = tmp + 1;
        if(sub)
            if (tmp > 5'b00001)
                tmp = tmp - 1;
    end
    assign display = tmp;
    
endmodule
