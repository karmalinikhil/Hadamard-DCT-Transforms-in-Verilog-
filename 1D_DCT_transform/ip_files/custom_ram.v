`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2024 11:31:39 PM
// Design Name: 
// Module Name: custom_ram
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
module custom_ram (
    input wire clk,
    input wire rst_n,        // Active low reset
    input wire write,        // Write enable signal
    input wire [3:0] write_addr, // Write address (4 bits for 16 locations)
    input wire [21:0] din,   // 22-bit input data
    output reg [95:0] dout,
    output reg [21:0] final_dout   // 4 x 22-bit output data //86
);

    // RAM storage (16 locations, 22 bits each)
    reg [23:0] ram [0:15];

    // Internal signals
    reg [3:0] read_addr;     // Read address for auto-read
    reg ram_full;            // Flag to indicate RAM is full
    reg [3:0] write_count;   // Counter to track number of written elements

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset logic
            for (i = 0; i < 16; i = i + 1) begin
                ram[i] <= 22'b0;
            end
            dout <= 88'b0;
            ram_full <= 0;
            write_count <= 0;
            read_addr <= 0;
        end else begin
            // Write operation
            if (write) begin
          /*  if(write_addr % 2==0) begin 
                ram[write_addr] <= din>>2;
                end else begin */
                ram[write_addr] <= {4'b0000+din};
               
                write_count <= write_count + 1;
                end 
                // Check if RAM is full
                if (write_count == 4'd15) begin
                    ram_full <= 1;
                end
            end

            // Auto-read operation when RAM is full
            if (ram_full) begin
                dout <= {ram[read_addr] , ram[read_addr+1],ram[read_addr+2], ram[read_addr+3]} ;
                read_addr <= read_addr + 4;

                // Reset RAM full flag after reading all data
                if (read_addr + 4 >= 16) begin
                    ram_full <= 0;
                    write_count <= 0; // Reset the write counter
                    read_addr <= 0;   // Reset read address
                end
            end
            
        end
   

endmodule


