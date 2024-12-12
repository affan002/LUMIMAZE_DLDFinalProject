`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 11:53:25 AM
// Design Name: 
// Module Name: vga_sync
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


module vga_sync (h_count,v_count,h_sync, v_sync, video_on, x_loc, y_loc);
  input [9:0] h_count;
  input [9:0] v_count;
  output h_sync;
  output v_sync;
  output video_on;
  output [9:0] x_loc;
  output [9:0] y_loc;
  wire h_sync, v_sync, video_on; 


  //horizontal measurements
  localparam HD = 640;
  localparam HF = 16;
  localparam HB = 48;
  localparam HR = 96;
  
  // vertical measurements
  localparam VD = 480;
  localparam VF = 10;
  localparam VB = 33;	
  localparam VR = 2;
  
  assign x_loc = h_count;
  assign y_loc = v_count;
  assign video_on = (h_count < HD & v_count < VD);
  assign h_sync = h_count < HD + HF | h_count > HD + HF + HR;
  assign v_sync = v_count < VD + VF | v_count >= VD + VF + VR;
endmodule
