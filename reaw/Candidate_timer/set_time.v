`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2020 11:10:05 AM
// Design Name: 
// Module Name: set_time
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


module set_time(
    input add,
    input sub,
    input score_based,
    output [7:0] max_time
    );
    
    reg [7:0]tmp = 30;
    wire addsub = add | sub;
    
    always @ (posedge addsub)
    begin
        if(score_based)
        begin
            if(add)
                if (tmp < 180)
                    tmp = tmp + 30;
            if(sub)
                if (tmp > 30)
                    tmp = tmp - 30;
        end
    end
    assign max_time = tmp;
endmodule
