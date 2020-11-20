`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 11:23:01 PM
// Design Name: 
// Module Name: state_control
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


module state_control(
    input clk_f, left_hit, right_hit, launch, reset,
    output [31:0] dstate
    );
    integer state = menu;
    parameter menu = 0, set = 1, start = 2, play = 3, end_point = 4, end_game = 5;
    integer pre_launch = 0;
    always @ (left_hit or right_hit or reset or launch)
    begin
        case(state)
        menu:
            begin
                if(pre_launch == 1 && launch == 0)
                    begin
                        state = set;
                    end
                else
                    begin
                        if(launch == 1)
                            begin
                                pre_launch = 1;
                            end
                        else
                            begin
                                pre_launch = 0;
                            end
                    end
            end
        set:
            begin
                if(pre_launch == 1 && launch == 0)
                        begin
                            state = start;
                        end
                else
                    begin
                        if(launch == 1)
                            begin
                                pre_launch = 1;
                            end
                        else
                            begin
                                pre_launch = 0;
                            end
                    end
            end
        start:
                begin
                    if(launch)
                        begin
                            state = play;
                        end
                    else state = start;
                end
        play:
                begin
                    if (left_hit || right_hit)
                        begin
                            state = end_point;
                        end
                    else 
                        begin
                            state = play;
                        end
                end
        end_point:
                begin
                    if(reset)
                        begin
                            state = end_game;
                        end
                    else state = start;
                end
        end_game:
                begin
                    state = end_game;
                    //if (sw[2])
                    //state = menu;
                end
            
        endcase 
    end
    assign dstate = state;
endmodule
