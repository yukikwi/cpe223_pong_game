`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    input [0:0]sw,
    input btnU,
    input btnL,
    input btnR,
    input btnD,
    output wire hsync,
    output wire vsync,
    output reg[11:0] rgb
    );
    
//    wire h_sync, v_sync;
    wire [9:0] x,y;
    wire clk_pix;
    //reg data_en;
    
    vga_sync display (.clk(clk), .reset(sw[0]), .hsync(hsync), 
                        .vsync(vsync), .video_on(), .p_tick(clk_pix), .x(x), .y(y));
    
    reg [9:0] H_screen = 640;
    reg [9:0] V_screen = 480;
    
    reg [7:0] ball_size = 10;
    reg [3:0] ball_speed_x = 2;
    reg [3:0] ball_speed_y = 2;
    reg [9:0] ball_x = 0;
    reg [9:0] ball_y = 0;
    
    reg [4:0] border_width = 10;
    
    reg dx, dy;
    
    
    //drawing start here --------------------------------
    
    //draw ball here
    reg ball_draw;
    always @ (*)
    begin
        ball_draw = (x < ball_x + ball_size)&&(x >= ball_x)&&(y < ball_y + ball_size)&&(y >= ball_y);
    end
    //draw border line
    reg border_H;
    reg border_V;
    
    always @ (*)
    begin
        //border = (x < H_screen) && (y < border_width) || (y >= V_screen - border_width && y < V_screen);
        border_H = (x < H_screen) && ((y < border_width) || (y >= V_screen - border_width && y < V_screen));
        border_V = (x < border_width) || (x >= H_screen - border_width && x < H_screen) && (y < V_screen);
    end
    
    //paddle draw
    reg [3:0] p_width = 8;
    reg [6:0] p_high = 96;
    reg [4:0] p_offset = 20;
    reg [9:0] p1_y = 192;
    reg [9:0] p2_y = 192;
    reg [2:0] p_speed = 1;
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
            if((ball_x < p_offset + border_width + p_width) && ((ball_y + ball_size > p1_y) || (ball_y < p1_y + p_high)))
                p1_col <= 1;
            if((ball_x > H_screen - (p_offset + border_width + p_width)) && ((ball_y + ball_size > p1_y) || (ball_y < p1_y + p_high)))
                p1_col <= 1;
        end
    end
    
    always @ (posedge clk_pix)
    begin
        if (animate)
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
            //if (ball_x >= H_screen - (ball_size + ball_speed_x))
            else if (ball_x >= H_screen - (ball_size + ball_speed_x + border_width))
            begin
                dx <= 1; //right edge
                ball_x <= ball_x - ball_speed_x;
            end
            //else if(ball_x < ball_speed_x)
            else if(ball_x < border_width + 1)
            begin
                dx <= 0; //left edge
                ball_x <= ball_x + ball_speed_x;
            end
            else ball_x = (dx)?ball_x - ball_speed_x : ball_x + ball_speed_x;
            
            //if (ball_y >= V_screen - (ball_size + ball_speed_y))
            if (ball_y >= V_screen - (ball_size + ball_speed_y + border_width))
            begin
                dy <= 1; //bottom edge
                ball_y <= ball_y - ball_speed_y;
            end
            //else if(ball_y < ball_speed_y)
            else if(ball_y < border_width + 1)
            begin
                dy <= 0; //top edge
                ball_y <= ball_y + ball_speed_y;
            end
            else ball_y = (dy)?ball_y - ball_speed_y : ball_y + ball_speed_y;

        end
    end
    
    
    
    always @ (posedge clk)
    begin
        if(ball_draw || border_H || border_V || p1_draw || p2_draw)
            rgb <= 12'hfff;
        else rgb = 12'h000;
    end
    
endmodule
