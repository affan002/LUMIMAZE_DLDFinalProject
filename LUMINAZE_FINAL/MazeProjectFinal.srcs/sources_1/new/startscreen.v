`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 11:58:57 AM
// Design Name: 
// Module Name: startscreen
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


module startscreen(pixel_x, pixel_y, flag);
  input [9:0] pixel_x;
  input [9:0] pixel_y;
  output flag;
  
  // defining 30x30 grid
  reg [0:29] startscreen [29:0];
  
  // assigning x and y  coordinates according to our grid 
  wire [5:0] x = pixel_x[9:4] - 5;
  wire [5:0] y = pixel_y[9:4];
  
  // flag to help render the start screen
  assign flag = startscreen[y][x];
  
  initial begin
 
    // 30 by 30 matrix (1 represents pixels for the letters)
    startscreen[0]  = 30'b111111111111111111111111111111;   
    startscreen[1]  = 30'b100000000000000000000000000001;
    startscreen[2]  = 30'b100000000000000000000000000001;
    startscreen[3]  = 30'b100000000000000000000000000001;
    startscreen[4]  = 30'b100000000000000000000000000001;
    startscreen[5]  = 30'b100000000000000000000000000001;
    startscreen[6]  = 30'b100000000000000000000000000001;
    startscreen[7]  = 30'b100100000100001011000110100001;
    startscreen[8]  = 30'b100100000100001010101010100001;
    startscreen[9]  = 30'b100100000100001010010010100001;
    startscreen[10] = 30'b100100000100001010000010100001;
    startscreen[11] = 30'b100100000100001010000010100001;
    startscreen[12] = 30'b100100000100001010000010100001;
    startscreen[13] = 30'b100111110111111010000010100001;
    startscreen[14] = 30'b100000000000000000000000000001;
    startscreen[15] = 30'b100000000000000000000000000001;
    startscreen[16] = 30'b100110001101110111110011110001;
    startscreen[17] = 30'b100101010101010000110010000001;
    startscreen[18] = 30'b100100100101110001000010000001;
    startscreen[19] = 30'b100100000101010010000011110001;
    startscreen[20] = 30'b100100000101010100000010000001;
    startscreen[21] = 30'b100100000101010100000010000001;
    startscreen[22] = 30'b100100000101010111110011110001;
    startscreen[23] = 30'b100000000000000000000000000001;
    startscreen[24] = 30'b100000000000000000000000000001;
    startscreen[25] = 30'b100000000000000000000000000001;
    startscreen[26] = 30'b100000000000000000000000000001;
    startscreen[27] = 30'b111111111111111111111111111111;
    startscreen[28] = 30'b111111111111111111111111111111;
    startscreen[29] = 30'b111111111111111111111111111111;
    
    

  end
endmodule