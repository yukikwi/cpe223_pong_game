`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Phawit Pukamkom, Thanawat Sophiphong, Pachara Chantawong
// 
// Create Date: 11/14/2020 02:33:19 PM
// Design Name: 
// Module Name: draw_ball
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


module draw_ball(
    input clk,
    input [1:0]sw,
    input wire btnU,
    input wire btnL,
    input wire btnR,
    input wire btnD,
    input wire btnC,
    output wire hsync,
    output wire vsync,
    output reg[11:0] rgb,
    output [15:0] led
    );
    wire [9:0] x,y;
    wire clk_pix;
    
    vga_sync display (.clk(clk), .reset(sw[0]), .hsync(hsync), 
                        .vsync(vsync), .video_on(), .p_tick(clk_pix), .x(x), .y(y));
    
    reg [9:0] H_screen = 640;
    reg [9:0] V_screen = 480;
    
    reg [7:0] ball_size = 10;
    reg [3:0] ball_speed_x = 2;
    reg [3:0] ball_speed_y = 2;
    reg [9:0] ball_x = 0;
    reg [9:0] ball_y = 235;
    
    reg [4:0] border_width = 10;
    
    reg dx, dy;
    
    reg right_hit = 0;
    reg left_hit = 0;
    
    //game state
    integer state, next_state;
    parameter start = 0, play = 1, end_point = 2;
    
    //debug state
    assign debugled = state;
    
    wire p1_up = btnU;
    wire p1_down = btnD;
    wire p2_up = btnL;
    wire p2_down = btnR;
    wire launch = btnC;  
//    integer right_score, left_score;
    
//    assign led[4:0] = right_score[4:0];
//    assign led[15:11] = left_score[4:0];    
    initial 
        begin 
            state = start; 
//            left_score = 0;
//            right_score = 0;
        end
    always @ (*)
    begin
        case(state)
        start:
                begin
                    if (launch)
                        next_state = play;
                    else next_state = start;
                end
        play:
                begin
                    if (left_hit || right_hit)
                    begin
//                        if(left_hit)
//                            right_score = right_score + 1;
//                        if(right_hit)
//                            left_score = left_score + 1;
                        next_state = end_point;
                    end
                    else next_state = play;
                end
        end_point:
                begin
                    next_state = start;
                end
            
        endcase 
    end
    
    always @ (posedge clk_pix)
    begin
        state <= next_state;
    end
    
    //drawing start here --------------------------------
    
    //draw ball here
    reg ball_draw;
    always @ (*)
    begin
        ball_draw = (x < ball_x + ball_size)&&(x >= ball_x)&&(y < ball_y + ball_size)&&(y >= ball_y);
    end
    reg border_H;
    reg border_V;
    
    always @ (*)
    begin
        border_H = (x < H_screen) && ((y < border_width) || (y >= V_screen - border_width && y < V_screen));
        border_V = (x < border_width) || (x >= H_screen - border_width && x < H_screen) && (y < V_screen);
    end
    
    //paddle draw
    reg [3:0] p_width = 8;
    reg [6:0] p_high = 96;
    reg [4:0] p_offset = 20;
    reg [9:0] p1_y = 192;
    reg [9:0] p2_y = 192;
    reg [2:0] p_speed = 2;
    reg p1_draw, p2_draw;
    
    always @ (*)
    begin
        p1_draw = (x >= p_offset + border_width) && (x < p_offset + border_width + p_width) && (y >= p1_y) && (y < p1_y + p_high);
        p2_draw = (x >= H_screen - (p_offset + border_width + p_width)) && (x < H_screen - (p_offset + border_width)) && (y >= p2_y) && (y < p2_y + p_high);
    end
    
    //------------------------------------------------
    
    reg animate;
    always @ (*)
    begin
        animate = (y == 480 && x == 0);
    end
    
    //colision detection
    reg p1_col, p2_col;
    
    always @ (posedge clk_pix)
    begin
        if (animate)
        begin
            p1_col <= 0;
            p2_col <= 0;
        end
        else if (ball_draw)
        begin
            if(p1_draw) p1_col <= 1;
            if(p2_draw) p2_col <= 1;
        end
    end

    //ball animation
    always @ (posedge clk_pix)
    begin
        if (state == start)
        begin
            ball_x <= border_width + p_offset + p_width;
            ball_y <= 235;
            right_hit <= 0;
            left_hit <= 0;
            
        end
        else if (animate)
        begin
            if(p1_col) //p1_collision
            begin
                dx <= 0;
                ball_x <= ball_x + ball_speed_x;
            end
            else if(p2_col)//p2 collision
            begin
                dx <= 1; 
                ball_x <= ball_x - ball_speed_x;
            end
            else if (ball_x >= H_screen - (ball_size + ball_speed_x + border_width))
            begin
                  right_hit <= 1;
            end
            else if(ball_x < border_width + 1)
            begin
                  left_hit <= 1;
            end
            else ball_x = (dx)?ball_x - ball_speed_x : ball_x + ball_speed_x;
            
            if (ball_y >= V_screen - (ball_size + ball_speed_y + border_width))
            begin
                dy <= 1; //bottom edge
                ball_y <= ball_y - ball_speed_y;
            end
            else if(ball_y < border_width + 1)
            begin
                dy <= 0; //top edge
                ball_y <= ball_y + ball_speed_y;
            end
            else ball_y = (dy)?ball_y - ball_speed_y : ball_y + ball_speed_y;
        end
    end
    
    //paddle animation
 
    always @ (posedge clk_pix)
    begin
        if(state == start)
        begin
            p1_y <= 192;
            p2_y <= 192;
        end
        if(animate)
        begin
            if (p1_up)
            begin
                if(p1_y > border_width)
                    p1_y <= p1_y - p_speed;
            end
            else if (p1_down)
            begin
                if(p1_y < V_screen - (border_width + p_high))
                    p1_y <= p1_y + p_speed;
            end
            
            if (p2_up)
            begin
                if(p2_y > border_width)
                    p2_y <= p2_y - p_speed;
            end
            else if (p2_down)
            begin
                if(p2_y < V_screen - (border_width + p_high))
                    p2_y <= p2_y + p_speed;
            end
        end
    end
    
    always @ (posedge clk)
    begin
        if(ball_draw || border_H || border_V || p1_draw || p2_draw)
            rgb <= 12'hfff;
        else rgb = 12'h000;
    end
    
endmodule
