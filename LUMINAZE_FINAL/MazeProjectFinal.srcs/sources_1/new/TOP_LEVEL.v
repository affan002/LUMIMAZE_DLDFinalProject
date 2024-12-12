`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2024 01:08:49 PM
// Design Name: 
// Module Name: TOP_LEVEL
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


`timescale 1ns / 1ps

module TOP_LEVEL (
    input start,          
    input restart,        
    input clk,            
    input wire LDR1,      
    input wire LDR2,      
    input wire LDR3,      
    input wire LDR4,      
    output wire clk_d,    
    output wire h_sync,   
    output wire v_sync,   
    output wire [3:0] red,   
    output wire [3:0] green, 
    output wire [3:0] blue   
);

    // registerting wires
    wire [9:0] h_count;       
    wire [9:0] v_count;       
    wire trig_v;              
    wire video_on;            
    wire [9:0] x_loc;         
    wire [9:0] y_loc;         
    wire [3:0] keys;          

    
    // Module instantiations 
    clk_div clock(clk, clk_d);
    LDR_integration ldr_intg(clk_d, LDR1, LDR2, LDR3, LDR4, keys);
    h_counter hc(clk_d, h_count, trig_v);
    v_counter vc(clk_d, trig_v, v_count);
    vga_sync vgas(h_count, v_count, h_sync, v_sync, video_on, x_loc, y_loc);
    pixel_gen pg(clk_d,x_loc,y_loc, v_sync, video_on,keys,start,restart,red,green,blue);

endmodule
