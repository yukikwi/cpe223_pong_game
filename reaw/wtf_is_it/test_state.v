`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2020 01:35:56 PM
// Design Name: 
// Module Name: test_state
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


module test_state(
    input clk,
    input btnC,
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    output reg[5:0] led
    );
    
    wire launch = btnC;
    wire left = btnL;
    wire right = btnR;
    wire up = btnU;
    wire down = btnD;
    
    //parameter menu = 0, set = 1, start = 2, play = 3, end_point = 4, end_game = 5;
    reg [3:0] state, next_state;
    initial 
    begin
        led = 6'b00000;
        state = 0; 
        next_state = 0;   
    end
    reg state_ctrl;
    reg state_ctrl2;
    always @ (state_ctrl, down, up, left, right)
    begin
        if(state_ctrl || down || up) state_ctrl2 = 1;
        else state_ctrl2 = 0;
    end
    always @ (posedge clk)
    begin
        if(launch)
            state_ctrl = 1;
        else state_ctrl = 0;
    end
    
    always @(posedge state_ctrl2)
    begin
        case(state)
            0: 
                begin
                    if(launch)
                        next_state = 1;
                end
            1:
                begin
                    if(launch)
                        next_state = 2;
                end
            2:
                begin
                    if(launch)
                        next_state = 3;
                end
            3:
                begin
                    if(up == 1 || down == 1)
                        next_state = 4;
                    else
                        next_state = 3;
                end
            4:
                begin
                    if(left == 1)
                        next_state = 5;
//                    else
//                        next_state = start;
                end
            5:
                begin
                    if(launch == 1)
                        next_state = 0;
                end
        endcase 
    end
    
    always @ (posedge clk)
    begin
        state = next_state;
        led[3:0] = state;
        led[4] = state_ctrl2;
        led[5] = up;
    end
    
endmodule
