
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 06:49:58 PM
// Design Name: 
// Module Name: DCT_tb
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


module DCT_tb ();

    reg [7:0] din;
    reg clk;
    reg rst_n;
    reg wen;
    

  DCT_source uut (
        .din(din),
        .clk(clk),
        .rst_n(rst_n),
        .wen(wen)
        
        
       
    );

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz clock

    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 0;
        wen = 0;
      
       
        
        #100;
        rst_n = 1;
       
         #20;
        din = 8'd5; wen = 1'b1; // Write value 0
     
        #10 wen = 0; // Disable write
        #20 din = 8'd7; wen = 1;  // Write value 1
     
        #20 wen = 0;
        #20 din = 8'd2; wen = 1;// Write value 2
        #50 wen = 0;
        #20 din = 8'd1; wen = 1;  // Write value 3
        #20 wen = 0;
        #10 din = 8'd5; wen = 1;  // Write value 4
        #70 wen = 0;
        #20 din = 8'd7; wen = 1;  // Write value 5
        #20 wen = 0;
        #20 din = 8'd2; wen = 1;  // Write value 6
        #70 wen = 0;
        #20 din = 8'd1; wen = 1; // Write value 7
        #90 wen = 0;
        #20 din = 8'd5; wen = 1;  // Write value 8
        #20 wen = 0;
        #20 din = 8'd7; wen = 1;  // Write value 9
        #20 wen = 0;
        #20 din = 8'd2; wen = 1;// Write value 10
        #20 wen = 0;
        #20 din = 8'd1; wen = 1;  // Write value 11
        #20 wen = 0;
        #20 din = 8'd5; wen = 1;  // Write value 12
        #20 wen = 0;
        #20 din = 8'd7; wen = 1;  // Write value 13
        #20 wen = 0;
        #20 din = 8'd2; wen = 1;  // Write value 14
        #20 wen = 0;
        #20 din = 8'd1; wen = 1; // Write value 15
        #20 wen = 0;
        

      
    end

endmodule


