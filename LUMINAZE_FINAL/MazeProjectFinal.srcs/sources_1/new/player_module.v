`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 11/18/2024 12:35:06 PM
//// Design Name: 
//// Module Name: player_module
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


module player_module(
  input clk,
  input [9:0] pixel_x,
  input [9:0] pixel_y,
  output wire player_flag,
  input [3:0] keys,
  input reset,
  input maze_pix,
  output wire [9:0] player_x_pos,
  output wire [9:0] player_y_pos
  );
  
  reg [9:0] x_pos;      // current x position
  reg [9:0] y_pos;      // current y position
  reg [15:0] player_arr [15:0];     // 2D array for player sprite
  
  assign player_x_pos = x_pos;      // output for current x position
  assign player_y_pos = y_pos;      // output for current y position
  
  reg new_frame;                // flag for checking end of frame
  reg [3:0] collision = 0;      // collision array
  
  always @(posedge clk) begin
        if (maze_pix == 1) begin // collision detection
            if (pixel_y == y_pos && ((x_pos + 1 <= pixel_x) && (pixel_x <= x_pos + 14))) collision[0] = 1;
            if (pixel_y == y_pos+15 && ((x_pos + 1 <= pixel_x) && (pixel_x < x_pos + 14))) collision[1] = 1;
            if (pixel_x == x_pos && ((y_pos + 1 <= pixel_y) && (pixel_y < y_pos + 14))) collision[2] = 1;
            if (pixel_x == x_pos+15 && ((y_pos + 1 <= pixel_y) && (pixel_y < y_pos + 14))) collision[3] = 1;
        end
        if (pixel_y == 481 && pixel_x == 0) begin
            collision = 0;
        end

        new_frame <= (pixel_y == 480 && pixel_x == 0);
  end
   
  always @(posedge new_frame) begin
    if (reset == 1) begin
        x_pos = 559 - 48; 
        y_pos = 390;        
    end 

    else begin
        // Move up
        if (keys == 4'b0001 && collision[0] == 0) 
            y_pos <= y_pos - 1;
        else if (collision[0] == 1) 
            y_pos <= y_pos + 1;
        
        // Move down
        else if (keys == 4'b0010 && collision[1] == 0) 
            y_pos <= y_pos + 1;
        else if (collision[1] == 1)
            y_pos <= y_pos - 1;
    
        // Move left
        else if (keys == 4'b0100 && collision[2] == 0) 
            x_pos <= x_pos - 1;
        else if (collision[2] == 1) 
            x_pos <= x_pos + 1;
    
        // Move right
        else if (keys == 4'b1000 && collision[3] == 0) 
            x_pos <= x_pos + 1;
        else if (collision[3] == 1) 
            x_pos <= x_pos - 1;
    end
  end

    // assigning flag for player placement and rendering
    assign player_flag = (((x_pos <= pixel_x) && (pixel_x < x_pos + 16)) && 
                          ((y_pos <= pixel_y) && (pixel_y < y_pos + 16))) 
                          ? player_arr[pixel_y - y_pos][pixel_x - x_pos]
                          : 0;

  initial begin
    // Initialize player sprite
    player_arr[0]  = 16'b0000000000000000;
    player_arr[1]  = 16'b0000000000000000;
    player_arr[2]  = 16'b0000000000000000;
    player_arr[3]  = 16'b0000011111100000;
    player_arr[4]  = 16'b0000111111110000;
    player_arr[5]  = 16'b0001111111111000;
    player_arr[6]  = 16'b0001111111111000;
    player_arr[7]  = 16'b0001111111111000;
    player_arr[8]  = 16'b0111111111111110;
    player_arr[9]  = 16'b1111111111111111;
    player_arr[10] = 16'b1111111111111111;
    player_arr[11] = 16'b1111111111111111;
    player_arr[12] = 16'b0111111111111110;
    player_arr[13] = 16'b0000000000000000;
    player_arr[14] = 16'b0000000000000000;
    player_arr[15] = 16'b0000000000000000;
  end
endmodule

