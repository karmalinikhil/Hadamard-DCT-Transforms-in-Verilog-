`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2025 06:28:34 PM
// Design Name: 
// Module Name: DCT_2D_tb
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



module DCT_2D_tb ();

    reg [7:0] din0;
    reg [7:0] din1;
    reg [7:0] din2;
    reg [7:0] din3;
    
    reg clk;
    reg rst_n;
   
    reg wen0;
    reg wen1;
    reg wen2;
    reg wen3;
    
    

   DCT_2D_source_final tb (
	    .din0(din0),
	    .din1(din1),
	    .din2(din2),
	    .din3(din3),
	    .clk(clk),
	    .rst_n(rst_n),
	    .wen0(wen0),
	    .wen1(wen1),
	    .wen2(wen2),
	    .wen3(wen3)
    
);

    // Clock generation
    always #10 clk = ~clk;  // 100 MHz clock

    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 0;
        
        
        
        wen0 = 0;
      
       
        
        #100;
        rst_n = 1;
        
      
        #20;
            din0 = 8'd5;   din1=8'd1;  din2=8'd14;  din3 = 8'd9;  wen0 = 1'b1; wen1 =1'b1; wen2=1'b1; wen3 = 1'b1;  
        #20 din0 = 8'd7;   din1=8'd5;  din2=8'd5;  din3 = 8'd32;      
        #20 din0 = 8'd2;   din1=8'd11;  din2=8'd5;  din3 = 8'd45;
        #20 din0 = 8'd1;   din1=8'd23;  din2=8'd2;  din3 = 8'd1;       
        #20 din0 = 8'd5;   din1=8'd1;  din2=8'd14;  din3 = 8'd9;    
        #20 din0 = 8'd7;   din1=8'd5;  din2=8'd5;  din3 = 8'd32;      
        #20 din0 = 8'd2;   din1=8'd11;  din2=8'd5;  din3 = 8'd45;     
        #20 din0 = 8'd1;   din1=8'd23;  din2=8'd2;  din3 = 8'd1;   
        #20 din0 = 8'd5;   din1=8'd1;  din2=8'd14;  din3 = 8'd9;       
        #20 din0 = 8'd7;   din1=8'd5;  din2=8'd5;  din3 = 8'd32;
        #20 din0 = 8'd2;   din1=8'd11;  din2=8'd5;  din3 = 8'd45;
        #20 din0 = 8'd1;   din1=8'd23;  din2=8'd2;  din3 = 8'd1;
        #20 din0 = 8'd5;   din1=8'd1;  din2=8'd14;  din3 = 8'd9;     
        #20 din0 = 8'd7;   din1=8'd5;  din2=8'd5;  din3 = 8'd32;
        #20 din0 = 8'd2;   din1=8'd11;  din2=8'd5;  din3 = 8'd45;
        #20 din0 = 8'd1;   din1=8'd23;  din2=8'd2;  din3 = 8'd1;
       // #20 wen0 = 1'b0; wen1 =1'b0; wen2=1'b0; wen3 = 1'b0;  
        
       /* #20;
           din0 = 8'd5;   din1=8'd7;  din2=8'd2;  din3 = 8'd1;  wen0 = 1'b1; wen1 =1'b1; wen2=1'b1; wen3 = 1'b1;  
        #20 din0 = 8'd1;   din1=8'd5;  din2=8'd11;  din3 = 8'd23;      
        #20 din0 = 8'd14;   din1=8'd5;  din2=8'd5;  din3 = 8'd2;
        #20 din0 = 8'd9;   din1=8'd2;  din2=8'd45;  din3 = 8'd1;    
        #20  din0 = 8'd5;   din1=8'd7;  din2=8'd2;  din3 = 8'd1;  
        #20 din0 = 8'd1;   din1=8'd5;  din2=8'd11;  din3 = 8'd23;      
        #20 din0 = 8'd14;   din1=8'd5;  din2=8'd5;  din3 = 8'd2;
        #20 din0 = 8'd9;   din1=8'd2;  din2=8'd45;  din3 = 8'd1;
        #20  din0 = 8'd5;   din1=8'd7;  din2=8'd2;  din3 = 8'd1;  
        #20 din0 = 8'd1;   din1=8'd5;  din2=8'd11;  din3 = 8'd23;      
        #20 din0 = 8'd14;   din1=8'd5;  din2=8'd5;  din3 = 8'd2;
        #20 din0 = 8'd9;   din1=8'd2;  din2=8'd45;  din3 = 8'd1;
        #20  din0 = 8'd5;   din1=8'd7;  din2=8'd2;  din3 = 8'd1;  
        #20 din0 = 8'd1;   din1=8'd5;  din2=8'd11;  din3 = 8'd23;      
        #20 din0 = 8'd14;   din1=8'd5;  din2=8'd5;  din3 = 8'd2;
        #20 din0 = 8'd9;   din1=8'd2;  din2=8'd45;  din3 = 8'd1; */
        
      
        
       /* #20;
        rst_n_0 = 0;
        rst_n_1 = 1;
        rst_n_2 = 0;
        rst_n_3 = 0;
        
        din1 = 8'd5; wen1 = 1'b1;     
        #20 din1 = 8'd7;      
        #20 din1 = 8'd2;    
        #20 din1 = 8'd1;         
        #20 din1 = 8'd5;      
        #20 din1 = 8'd7;        
        #20 din1 = 8'd2;        
        #20 din1 = 8'd1;      
        #20 din1 = 8'd5;         
        #20 din1 = 8'd7;  
        #20 din1 = 8'd2;
        #20 din1 = 8'd1;  
        #20 din1 = 8'd5;        
        #20 din1 = 8'd7;  
        #20 din1 = 8'd2; 
        #20 din1 = 8'd1;
        
        #20;
        rst_n_0 = 0;
        rst_n_1 = 0;
        rst_n_2 = 1;
        rst_n_3 = 0;
        
        din2 = 8'd5; wen2 = 1'b1;     
        #20 din2 = 8'd7;      
        #20 din2 = 8'd2;    
        #20 din2 = 8'd1;         
        #20 din2 = 8'd5;      
        #20 din2 = 8'd7;        
        #20 din2 = 8'd2;        
        #20 din2 = 8'd1;      
        #20 din2 = 8'd5;         
        #20 din2 = 8'd7;  
        #20 din2 = 8'd2;
        #20 din2 = 8'd1;  
        #20 din2 = 8'd5;        
        #20 din2 = 8'd7;  
        #20 din2 = 8'd2; 
        #20 din2 = 8'd1;
        
        #20;
        rst_n_0 = 0;
        rst_n_1 = 0;
        rst_n_2 = 0;
        rst_n_3 = 1;
        
        din3 = 8'd5; wen3 = 1'b1;     
        #20 din3 = 8'd7;      
        #20 din3 = 8'd2;    
        #20 din3 = 8'd1;         
        #20 din3 = 8'd5;      
        #20 din3 = 8'd7;        
        #20 din3 = 8'd2;        
        #20 din3 = 8'd1;      
        #20 din3 = 8'd5;         
        #20 din3 = 8'd7;  
        #20 din3 = 8'd2;
        #20 din3 = 8'd1;  
        #20 din3 = 8'd5;        
        #20 din3 = 8'd7;  
        #20 din3 = 8'd2; 
        #20 din3 = 8'd1;
        */
    
      
    end

endmodule
