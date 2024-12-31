`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 11:55:38 AM
// Design Name: 
// Module Name: pixel_gen
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
module pixel_gen(
    input clk_d,               
    input [9:0] pixel_x,       
    input [9:0] pixel_y,     
    input v_sync,  
    input video_on,            
    input [3:0] keys,        
    input startgame,           
    input restart,             
    output reg [3:0] red = 0,  
    output reg [3:0] green = 0,
    output reg [3:0] blue = 0  
);

    // FSM States
    parameter START = 2'b00;
    parameter GAME = 2'b01;
    parameter WIN = 2'b10;
    parameter LOSE = 2'b11;

    // FSM state register
    reg [1:0] state = START;
    
    reg reset = 1;  
    
    
    //output wire for startscreen module and instantiation
    wire s1_pix; 
    startscreen s1(pixel_x, pixel_y, s1_pix);  

    //output wire for maze module and instantiation
    wire maze_pix; 
    maze m1(pixel_x, pixel_y, maze_pix);
  
    // output wires for player module(current x and y position and player pixel)
    wire [9:0] x_position;
    wire [9:0] y_position;
    wire player_pix;
    player_module player (clk_d,pixel_x,pixel_y,player_pix, keys, reset, maze_pix, x_position, y_position);

    // output wire for win screen pixels
    wire win_pix;
    win_screen win_s(pixel_x, pixel_y, win_pix);
    
    // output wire for loose screen pixels and instantiation
    wire lose_pix;
    lose_screen lose_s(pixel_x, pixel_y, lose_pix);
    
    // output wire for destination sprite pixels and instantiation
    wire dest;
    destination dest_s(pixel_x, pixel_y,dest);
    
    // boolean checks for 2 digits of the counter
    wire firstnum_flag;
    wire secondnum_flag;

    // framecount variable to control the speed of the timer
    reg [6:0] framecount;

    // registerating variables for timer
    reg [3:0] first_num ;
    reg [3:0] second_num ;
    reg timer_flag;
    

    initial begin
    timer_flag = 0;
    end
    
// FSM: State Transition Logic
always @(posedge v_sync) begin
        case (state)

            START: begin
                if (startgame) begin
                    state <= GAME;      // Transition to GAME state on startgame signal
                    reset <= 0;         // Release player reset in GAME state
                    second_num <= 4;
                    first_num <= 5;
                    timer_flag <= 0;
                    framecount <= 0;    // Reset framecount when starting
                end
            end

            GAME: begin

                // check player collision with destination
                if ((x_position >= 200 && x_position < 216) && (y_position >= 25 && y_position < 56)) begin
                    state <= WIN;
                end
                
                // Then check timer flag for lose condition
                else if (timer_flag) begin
                    state <= LOSE;
                end
                
                // Timer countdown logic
                framecount <= framecount + 1;
                if (framecount == 75)
                begin 
                    framecount <= 0;
                    first_num <= first_num - 1;

                    if (first_num== 0)
                    begin
                        first_num <= 9;
                        second_num <= second_num - 1;
                        if (second_num == 0)
                        begin
                            timer_flag <= 1;
                        end 
                    end
                end

                // Restart handling
                if (restart) begin
                    state <= START; // Transition back to START state on restart signal
                    reset <= 1;     // Assert player reset
                end
            end

            WIN: begin
                if (restart) begin
                    state <= START;
                    reset <= 1;
                end
            end

            LOSE: begin
                if (restart) begin
                    state <= START;
                    reset <= 1;
                end
            end

            default: begin
                state <= START;
                reset <= 1;
            end
        endcase
    end

 Counter_nums lastnum(clk_d, pixel_x, pixel_y, 10'd515, 10'd9, first_num, firstnum_flag);
 Counter_nums midnum(clk_d, pixel_x, pixel_y, 10'd493, 10'd9, second_num, secondnum_flag);
 
    // Color Generation Logic
    always @(posedge clk_d) begin
        if (video_on) begin
            if ((pixel_x <=80) || (pixel_x >=559)) begin 
                red <= 4'h0;
                green <= 4'h0;       
                blue <= 4'h0;
            end else begin
                case (state)

                    START: begin
                        // Render the start screen
                        if (s1_pix) begin
                            red <= 4'hf;
                            green <= 4'hf;
                            blue <= 4'hf;
                        end else begin
                            red <= 4'h0;
                            green <= 4'h0;
                            blue <= 4'h0;
                        end
                    end

                    GAME: begin

                        // Timer display
                        if (firstnum_flag || secondnum_flag) begin
                            red <= 4'hf;
                            green <= 4'hf;
                            blue <= 4'hf; 
                        end

                        // Player rendering
                        else if (player_pix) begin
                            red <= 4'hf;  
                            green <= 4'hf;
                            blue <= 4'hf;
                        end 

                        // Maze rendering
                        else if (maze_pix == 1) begin 
                            red <= 4'h9;
                            green <= 4'h2; 
                            blue <= 4'h2; 
                        end 

                        // destination rendering
                        else if (dest == 1)begin
                            red <= 4'hf;
                            green <= 4'hf; 
                            blue <= 4'h0; 
                        end

                        // Background
                        else begin
                            red <= 4'h2;
                            green <= 4'h2;
                            blue <= 4'h4;
                        end
                    end

                    WIN: begin
                        // Win screen rendering
                        if (win_pix) begin
                            red <= 4'h0;
                            green <= 4'h0;
                            blue <= 4'h0;
                        end else begin
                            red <= 4'h0;
                            green <= 4'hf;
                            blue <= 4'h0;
                        end
                    end

                    LOSE: begin
                        // Lose screen rendering
                        if (lose_pix) begin
                            red <= 4'h0;
                            green <= 4'h0;
                            blue <= 4'h0;
                        end else begin
                            red <= 4'hf;
                            green <= 4'h0;
                            blue <= 4'h0;
                        end
                    end
                endcase
            end
        end else begin
            red <= 4'h0;
            green <= 4'h0;
            blue <= 4'h0;
        end
    end
endmodule