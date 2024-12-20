`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2024 04:36:55 PM
// Design Name: 
// Module Name: win_screen
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

module win_screen(pixel_x, pixel_y, flag);
  input [9:0] pixel_x;
  input [9:0] pixel_y;
  output flag;
  
  // 30 x 30 grid for win screen
  reg [0:29] win [29:0];
  
  //scaling of the x and y coordinates to fit the grid
  wire [5:0] x = pixel_x[9:4] - 5;
  wire [5:0] y = pixel_y[9:4];

  // assigning flag for pixels of the win screen
  assign flag = win[y][x];
  
  initial begin
    
    // 30 by 30 bits array (1 represent the winning letters on the screen)
    win[0]  = 30'b111111111111111111111111111111;    
    win[1]  = 30'b100000000000000000000000000001;    
    win[2]  = 30'b100000000000000000000000000001;    
    win[3]  = 30'b100000000000000000000000000001;    
    win[4]  = 30'b100000000000000000000000000001;    
    win[5]  = 30'b100000000000000000000000000001;    
    win[6]  = 30'b100000000000000000000000000001;    
    win[7]  = 30'b100000000000000000000000000001;    
    win[8]  = 30'b100000001010011100101000000001;
    win[9]  = 30'b100000001010010100101000000001;
    win[10] = 30'b100000001010010100101000000001;
    win[11] = 30'b100000000100010100101000000001;
    win[12] = 30'b100000000100010100101000000001;
    win[13] = 30'b100000000100011100111000000001;
    win[14] = 30'b100000000000000000000000000001;
    win[15] = 30'b100000000000000000000000000001;
    win[16] = 30'b100000000000000000000000000001;
    win[17] = 30'b100001000100111001000101000001;
    win[18] = 30'b100001000100010001100101000001;
    win[19] = 30'b100001000100010001010101000001;
    win[20] = 30'b100001010100010001001101000001;
    win[21] = 30'b100001010100010001000100000001;
    win[22] = 30'b100001101100111001000101000001;
    win[23] = 30'b100000000000000000000000000001;
    win[24] = 30'b100000000000000000000000000001;
    win[25] = 30'b100000000000000000000000000001;
    win[26] = 30'b100000000000000000000000000001;
    win[27] = 30'b100000000000000000000000000001;
    win[28] = 30'b100000000000000000000000000001;
    win[29] = 30'b111111111111111111111111111111; 

    
 end
  
endmodule

