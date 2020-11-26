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
    input [2:0]sw,
    input [1:0] JA,
    input [1:0] JB,
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
    
    reg right_hit;
    reg left_hit;
    reg store_right_hit = 0;
    reg store_left_hit = 0;
    //game state
    reg [2:0] state = 0;
    reg [2:0] next_state;
//    wire [31:0] state;
    parameter menu = 0, set = 1, start = 2, play = 3, end_point = 4, end_game = 5;
    wire delayed;
    wire btnU;
    wire btnL;
    wire btnR;
    wire btnD;
    wire clk_2;
    assign btnD = JA[0];
    assign btnU = JA[1];
    assign btnL = JB[0];
    assign btnR = JB[1];
    wire p1_up = btnU;
    wire p1_down = btnD;
    wire p2_up = btnL;
    wire p2_down = btnR;
    wire launch = btnC;  
    
    reg start_player;
    integer pre_launch;
    
    wire [4:0] max_score;
    reg [4:0] score_p1;
    reg [4:0] score_p2;
    
    reg reset = 0;
    
    reg store_reset = 0;
//    reg reset_speed;
//    reg reset_score;
    wire clk_25Hz;
    divide clk_div_5Hz(clk, clk_25Hz);
    
    initial 
        begin 
            pre_launch = 0;
        end
        
    wire clk_f;
    
    fuckingcounter clk_fm(clk, clk_f);
    
    //state_control scontroller(clk_f, left_hit, right_hit, launch, reset, state);
    reg p_reset;
    reg state_ctrl;
    reg state_ctrl2;
    //wire state_ctrl2 = state_ctrl | left_hit | right_hit | reset;
    
    always @ (state_ctrl, left_hit, right_hit, reset)
    begin
        if(state_ctrl || left_hit || right_hit )
            state_ctrl2 = 1;
        else if(state == end_point) state_ctrl2 = clk_pix;
        else state_ctrl2 = 0;
    end 
        
    always @ (posedge clk_pix)
    begin
        if(launch)
            state_ctrl = 1;
        else state_ctrl = 0;
    end
    
    always @ (posedge state_ctrl2)
    begin
        case(state)
        menu:
            begin
                p_reset = 0;
                if(launch)
                    next_state = set;
            end
        set:
            begin
                p_reset = 0;
                if(launch)
                    next_state = start;
            end
        start:
                begin
                    p_reset = 0;
                    if(launch)
                        begin
                            next_state = play;
                        end
                    else next_state = start;
                end
        play:
                begin
                    p_reset = 0;
                    if (store_left_hit || store_right_hit)
                    begin
                        next_state = end_point;
                    end
                    else 
                    begin
                        next_state = play;
                    end
                end
        end_point:
                begin
                    p_reset = 0;
                    if(reset)
                    begin
                        next_state = end_game;
                    end
                    else 
                    begin
                        next_state = start;
                    end
                end
        end_game:
                begin
                    p_reset = 1;
                    if(launch)
                        next_state = menu;     
                end
        default:
                begin
                    p_reset = 0;
                    next_state = menu;
                end          
        endcase 
    end
    
    assign led[11:9] = state[2:0];
    assign led[8] = store_reset;
    assign led[7] = state_ctrl2;
    assign led[6] = store_left_hit;
    assign led[5] = store_right_hit;
    always @ (posedge clk_pix)
    begin
        state <= next_state;
    end
    
    reg draw_end;
    always @ (clk_pix)
    begin
        if(state == end_game)
            draw_end = (x>=20 && x<40) || (y>=20 && y<40);
    end
    
    
        // 7seg//score

    wire [6:0] displayP1_first;
    wire [6:0] displayP1_second;
    wire [6:0] displayP2_first;
    wire [6:0] displayP2_second;
    wire seg_firstP1;
    wire seg_secondP1;
    wire seg_firstP2;
    wire seg_secondP2;

    
    initial begin
        score_p1 = 5'b0;
        score_p2 = 5'b0;
    end
    //scoring
    wire [4:0] right_score, left_score;
    counter couter_p1(right_hit, p_reset, left_score);
    counter couter_p2(left_hit, p_reset, right_score);
    
    always @ (left_score)
    begin
        score_p1 = left_score;
    end
    always @ (right_score)
    begin
        score_p2 = right_score;
    end
    
    display_score score_player1(score_p1 , displayP1_first , displayP1_second);
    display_score score_player2(score_p2 , displayP2_first , displayP2_second);
    
    display_seg show_scoreP1First(displayP1_first , 242 , border_width + 15 , x , y , seg_firstP1);
    display_seg show_scoreP1Second(displayP1_second , 276 , border_width + 15 , x , y , seg_secondP1);
    display_seg show_scoreP2First(displayP2_first , 340 , border_width + 15 , x , y , seg_firstP2);
    display_seg show_scoreP2Second(displayP2_second , 374 , border_width + 15 , x , y , seg_secondP2);
    //end 7seg
    //End scoring
    
    //drawing start here --------------------------------
    
    //draw menu
    reg menu_draw;
    reg menu_border;
    wire score_based;
    
    //reg button_ctrl;
    
    
    //set scores
    reg add, sub;
    always @(posedge clk_25Hz)
    begin
        if(state == set)
        begin
            if(btnU)
            begin
                add = 1;
            end
            else if (btnD)
            begin
                sub = 1;
            end
            else
            begin
                add <= 0;
                sub <= 0;
            end
        end
    end
    
    set_scores set_scores(add, sub, max_score);
    assign led[4:0] = max_score;
//    assign led[15:13] = next_state[2:0];
//    assign led[12:10] = state[2:0];
    //compare score
    always @ (score_p1 or score_p2)
    begin
        if (score_p1 == max_score)
           begin
           reset = 1;
           store_reset = 1;
           end
        else if (score_p2 == max_score)
           begin
           reset = 1;
           store_reset = 1;
           end
        else reset = 0;
    end
    
    
    always @ (score_based)
    begin
        if(state == menu)
        begin
            menu_draw = (x >= 192) && (x < 448) && ((y >= 200 && y < 260) || (y >= 280 && y < 340));
            if (score_based)
            begin
                menu_border = (x >= 190 && x < 450) && (y >= 198 && y < 262);
            end
            else
            begin
                menu_border = (x >= 190 && x < 450) && (y >= 278 && y < 342);
            end
        end
        else menu_draw = 0;
    end
    
    //draw ball here
    reg ball_draw;
    always @ (posedge clk_pix)
    begin
        if (state == play || state == start || state == end_point)
        begin
            ball_draw = (x < ball_x + ball_size)&&(x >= ball_x)&&(y < ball_y + ball_size)&&(y >= ball_y);
        end
    end
    
    reg border_H;
    reg border_V;
    
    always @ (*)
    begin
        if(state == start || state == play || state == end_point)
        begin
            border_H = (x < H_screen) && ((y < border_width) || (y >= V_screen - border_width && y < V_screen));
            border_V = (x < border_width) || (x >= H_screen - border_width && x < H_screen) && (y < V_screen);
        end
    end
    
    //paddle draw
    reg [3:0] p_width = 8;
    reg [6:0] p_high = 96;
    reg [4:0] p_offset = 20;
    reg [9:0] p1_y = 192;
    reg [9:0] p2_y = 192;
    reg [2:0] p_speed = 2;
    reg p1_draw, p2_draw;
    
    always @ (posedge clk_pix)
    begin
        if (state == play || state == start || state == end_point)
        begin
            p1_draw = (x >= p_offset + border_width) && (x < p_offset + border_width + p_width) && (y >= p1_y) && (y < p1_y + p_high);
            p2_draw = (x >= H_screen - (p_offset + border_width + p_width)) && (x < H_screen - (p_offset + border_width)) && (y >= p2_y) && (y < p2_y + p_high);
        end
    end
    
    //------------------------------------------------
    
    reg animate;
    always @ (x, y)
    begin
        animate = (y == 480 && x == 0);
    end
    
    menu_ctrl controller_menu(p1_up, p1_down, animate, state, menu, score_based);
    
    
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
            if(p1_draw) 
            begin 
                p1_col <= 1;
            end
            if(p2_draw)
            begin 
                p2_col <= 1;
            end
        end
    end
    
    //ball animation
    always @ (posedge clk_pix)
    begin
        if (state == start)
        begin
            if (start_player == 0)
            begin
                ball_x <= border_width + p_offset + p_width;
                ball_y <= 235;
            end
            else
            begin
                ball_x <= H_screen - (border_width + p_offset + p_width + ball_size);
                ball_y <= 235;
            end
            store_right_hit = 0;
            store_left_hit = 0;
            right_hit <= 0;
            left_hit <= 0;
        end
        else if (state == play)
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
            else if (ball_x >= H_screen - (ball_size + ball_speed_x + border_width))
            begin
                  store_right_hit = 1;
                  right_hit <= 1;
                  start_player <= 1;
            end
            else if(ball_x < border_width + 1)
            begin
                  store_left_hit = 1;
                  left_hit <= 1;
                  start_player <= 0;
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
        else 
            begin   
                store_left_hit = 0;
                store_right_hit = 0;
                left_hit = 0;
                right_hit = 0;
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
//        else if(state == play)
//        begin
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
//            end
        end
    end
    //display menu
    wire display_menu;
    display_select_mode dmenu(201 , 80 , x , y , display_menu);
    //display setscore
    wire display_set_score;
    display_setscore dsetscore(max_score, x, y, display_set_score);
    //display end
    wire display_end_game;
    display_endgame dend(276 , 220 , x , y , display_end_game);
    
    reg draw = 0;
    always @ (posedge clk_pix)
    begin
    draw <= 0;
        if(state == menu)
        begin
            if(display_menu)
            begin
                draw <= 1;
                rgb <= 12'hf00;
            end
            else if(menu_draw)
                rgb <= 12'hfff; //white
            else if(menu_border)
                rgb <= 12'hAAA;
            else rgb = 12'h000;
        end
        else if(state == set)
        begin
            if(display_set_score)
                rgb <= 12'hfff;
            else rgb = 12'h000;
        end
        else if(state == end_game)
        begin
            if(display_end_game)
                rgb <= 12'hfff;
            else rgb = 12'h000;
        end
        else if(state == play || state == start || state == end_point)
        begin
            if(seg_firstP1 || seg_secondP1 || seg_firstP2 || seg_secondP2 || border_H || border_V)
                rgb <= 12'hfff;
            else if(ball_draw)
                rgb <= 12'h3f0;
            else if(p1_draw)
                rgb <= 12'h03F;
            else if(p2_draw)
                rgb <= 12'hf00;
            else rgb = 12'h000;
        end
        else rgb = 12'hfd0;
    end
    assign led[12] = draw;
endmodule
