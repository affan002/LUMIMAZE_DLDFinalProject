`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 03:40:26 PM
// Design Name: 
// Module Name: LDR_integration
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


module LDR_integration(
    input clk,
    
    // inputs from each LDR (4 LDRs in total)
    input wire input1,   
    input wire input2,   
    input wire input3,   
    input wire input4,   

    // 4 bit output (out) to determine direction 
    output reg [3:0] out 
);

always @(posedge clk) begin
    
    out = 4'b0000;
    
    if (~input1) begin  //Bit 0001 assigned for upward movement 
        out = 4'b0001;  
    end 
    else if (~input2) begin  //Bit 0010 assigned for downward movement
        out = 4'b0010;  
    end 
    else if (~input3) begin  // Bit 0100 assigned for left movement
        out = 4'b0100;  
    end 
    else if (~input4) begin  // Bit 1000 assigned for right movement
        out = 4'b1000; 
    end
end

endmodule