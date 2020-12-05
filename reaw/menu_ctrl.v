`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 10:26:13 AM
// Design Name: 
// Module Name: menu_ctrl
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


module menu_ctrl(
    input p1_up, p1_down, animate, 
    input [2:0] state, menu, 
    output reg out
    );
    
    reg button_ctrl;
    initial
        begin
            out = 0;
            button_ctrl = 0;
        end
    always @ (p1_up or p1_down)
    begin
        if(state == menu)
        begin
            if(animate)
                begin 
                    if(p1_up && button_ctrl != p1_up)
                    begin
                        out = 1;
                        button_ctrl = p1_up;
                    end
                    if(p1_down && button_ctrl != ~p1_down)
                    begin
                        out = 0;
                        button_ctrl = ~p1_down;
                    end
               end
        end
    end
endmodule
