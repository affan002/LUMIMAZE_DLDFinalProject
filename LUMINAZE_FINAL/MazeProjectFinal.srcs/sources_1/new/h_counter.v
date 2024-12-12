`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 11:48:55 AM
// Design Name: 
// Module Name: h_counter
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

module h_counter(clk,h_count,trig_v);
  input clk;
  output [9:0] h_count;
  output trig_v;
  reg [9:0] h_count;
  reg trig_v;
  initial 
    begin 
      h_count <= 0;
      trig_v <= 0;
    end
  always @(posedge clk)
    begin
      if (h_count < 799)
        begin
          h_count <= h_count + 1;
          trig_v <= 0;
        end
      else
        begin
          trig_v <= 1;
          h_count <= 0;
        end
    end
endmodule