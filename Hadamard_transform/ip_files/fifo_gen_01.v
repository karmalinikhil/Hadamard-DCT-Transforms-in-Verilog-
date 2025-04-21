`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2024 01:08:54 PM
// Design Name: 
// Module Name: fifo_gen_01
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


module fifocustom(
    input wire clk,
    input wire clk2,
    input wire wen,
    input wire ren,
    input wire [6:0] din,
    input wire rst_n,
    output reg [6:0] dout,
    output wire full,
    output wire empty,
    output reg valid
);

    reg [6:0] fifo_mem [0:15];  // FIFO memory with 16-depth and 7-bit data width
    reg [4:0] r_addr;
    reg [4:0] w_addr;

    wire full_flag;
    wire empty_flag;

    // Full and empty flag calculations
    assign full_flag = ((w_addr[4] != r_addr[4]) && (w_addr[3:0] == r_addr[3:0]));
    assign empty_flag = (w_addr == r_addr);

    assign full = full_flag;
    assign empty = empty_flag;

    // Write operation
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            w_addr <= 0;
        end 
        else if (wen && ~full_flag) begin
            fifo_mem[w_addr[3:0]] <= din;  
            w_addr <= w_addr + 1;          
        end
    end

    // Read operation
    always @(posedge clk2 or negedge rst_n) begin
        if (~rst_n) begin
            r_addr <= 0;
            dout <= 7'd0;
            valid <= 1'b0;
        end 
        else if (ren && ~empty_flag) begin
            dout <= fifo_mem[r_addr[3:0]];
            r_addr <= r_addr + 1;
            valid <= 1'b1;
        end
        else if (!ren || empty_flag) begin
            valid <= 1'b0;
        end
    end

endmodule