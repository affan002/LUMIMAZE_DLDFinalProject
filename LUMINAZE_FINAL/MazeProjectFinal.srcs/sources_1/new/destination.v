`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 05:59:50 PM
// Design Name: 
// Module Name: destination
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

module destination(pixel_x, pixel_y, flag);
  input [9:0] pixel_x;
  input [9:0] pixel_y;
  output flag;

  
  // 16 x 16 grid for the destination
  reg [15:0]  Destin [15:0];
  
  // check to ensure the pixels lie within the 16 x16 grid and its specified position on the screen
  assign flag = (((200 <= pixel_x) && (pixel_x <200 + 16)) && ((40 <= pixel_y) && (pixel_y <40 + 16))) ? (Destin[pixel_y - 280][pixel_x - 324]):0;

  initial begin
      
    // 16 by 16 array bits (1 represents the destination's sprite)
    Destin[0]  = 16'b0000000000000000;
    Destin[1]  = 16'b0000000000000000;
    Destin[2]  = 16'b0000000000000000;
    Destin[3]  = 16'b0000000000000000;
    Destin[4]  = 16'b0011000000000000;
    Destin[5]  = 16'b0110000000000000;
    Destin[6]  = 16'b1111111111111000;
    Destin[7]  = 16'b1111111111111000;
    Destin[8]  = 16'b0110000000000000;
    Destin[9]  = 16'b0011000000000000;
    Destin[10] = 16'b0000000000000000;
    Destin[11] = 16'b0000000000000000;
    Destin[12] = 16'b0000000000000000;
    Destin[13] = 16'b0000000000000000;
    Destin[14] = 16'b0000000000000000;
    Destin[15] = 16'b0000000000000000;  
  end
endmodule
