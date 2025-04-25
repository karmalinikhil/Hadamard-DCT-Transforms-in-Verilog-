`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 06:21:00 PM
// Design Name: 
// Module Name: DCT_source
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

module DCT_2D_source(
    input  [7:0] din0,
    input  [7:0] din1,
    input  [7:0] din2,
    input  [7:0] din3,
    input clk,
    input rst_n,
    input wen0,
    input wen1,
    input wen2,
    input wen3,
    output  reg [21:0] DCT_2D_out_r0,
    output  reg [21:0] DCT_2D_out_r1,
    output  reg [21:0] DCT_2D_out_r2,
    output  reg [21:0] DCT_2D_out_r3
);
    
reg ram_write_cnt_r0;
reg ram_write_cnt_r1;
reg ram_write_cnt_r2;
reg ram_write_cnt_r3;

reg ram_addr_cnt_r0;
reg ram_addr_cnt_r1;
reg ram_addr_cnt_r2;
reg ram_addr_cnt_r3;

    reg [7:0] dum_cnt;
    

    reg [21:0] DCT_r0_out; // 25 bits for the sum
    reg [21:0] DCT_r1_out; // 25 bits for the sum
    reg [21:0] DCT_r2_out; // 25 bits for the sum
    reg [21:0] DCT_r3_out; // 25 bits for the sum
    
    reg fifo_r0_wren;
    reg fifo_r0_reen;
    wire [7:0] fifo_r0_out; // change to wire if needed
    wire fifo_r0_full;
    wire fifo_r0_empty;
    
     reg [2:0] fifo_22x4_r0_off_cnt;
    reg [2:0] fifo_22x4_r1_off_cnt;
    reg [2:0] fifo_22x4_r2_off_cnt;
    reg [2:0] fifo_22x4_r3_off_cnt;
    
    
    
    reg fifo_r1_wren;
    reg fifo_r1_reen;
    wire [7:0] fifo_r1_out; // change to wire if needed
    wire fifo_r1_full;
    wire fifo_r1_empty;
    
    reg fifo_r2_wren;
    reg fifo_r2_reen;
    wire [7:0] fifo_r2_out; // change to wire if needed
    wire fifo_r2_full;
    wire fifo_r2_empty;
    
    reg fifo_r3_wren;
    reg fifo_r3_reen;
    wire [7:0] fifo_r3_out; // change to wire if needed
    wire fifo_r3_full;
    wire fifo_r3_empty;
    
    wire [21:0] mult_r0_out;
    wire [21:0] mult_r1_out;
    wire [21:0] mult_r2_out;
    wire [21:0] mult_r3_out;
    
    reg ram_write_r0;    
    reg [3:0] ram_addr_r0;    
    wire [95:0] ram_out_r0;
    
    reg ram_write_r1;    
    reg [3:0] ram_addr_r1;    
    wire [95:0] ram_out_r1;
    
    reg ram_write_r2;    
    reg [3:0] ram_addr_r2;    
    wire [95:0] ram_out_r2;
    
    reg ram_write_r3;    
    reg [3:0] ram_addr_r3;    
    wire [95:0] ram_out_r3;
    
    
    reg fifo_22x4_r0_wen;
    reg fifo_22x4_r0_ren;
    wire fifo_22x4_r0_full;
    wire fifo_22x4_r0_empty;
    wire [21:0] fifo_22x4_r0_out;
    
    reg fifo_22x4_r1_wen;
    reg fifo_22x4_r1_ren;
    wire fifo_22x4_r1_full;
    wire fifo_22x4_r1_empty;
    wire [21:0] fifo_22x4_r1_out;
    
    reg fifo_22x4_r2_wen;
    reg fifo_22x4_r2_ren;
    wire fifo_22x4_r2_full;
    wire fifo_22x4_r2_empty;
    wire [21:0] fifo_22x4_r2_out;
    
    reg fifo_22x4_r3_wen;
    reg fifo_22x4_r3_ren;
    wire fifo_22x4_r3_full;
    wire fifo_22x4_r3_empty;
    wire [21:0] fifo_22x4_r3_out;
    
    reg fifo_22x16_wen;
    reg fifo_22x16_ren;
    wire fifo_22x16_full;
    wire fifo_22x16_empty;
    wire [21:0] final_DCT_2D_out;
    
    reg [2:0] fifo_22x4_r0_wen_cnt;
    reg [2:0] fifo_22x4_r1_wen_cnt;
    reg [2:0] fifo_22x4_r2_wen_cnt;
    reg [2:0] fifo_22x4_r3_wen_cnt;
    
    reg fifo_22x4_r0_wen_delay;
    reg fifo_22x4_r1_wen_delay;
    reg fifo_22x4_r2_wen_delay;
    reg fifo_22x4_r3_wen_delay;
    
    reg [2:0] fifo_22x16_ren_cnt;
    
    reg d1;
    reg d2;
    reg d3;
    reg d4;
    reg d5;
    reg d6;
    reg d7;
    reg d8;

    reg [1:0] state_r0;
    reg [1:0] state_r1;
    reg [1:0] state_r2;
    reg [1:0] state_r3;
    
    reg [13:0] mult_B;
     // Corrected to match mult_gen_0 output size
    reg [3:0] mult_cnt;
    reg [3:0] state_cnt;
    reg ram_write;
    reg ram_read;
    reg [3:0] ram_addr;
    reg [21:0] ram_in;
    reg [21:0] ram_in_r1;
    reg [21:0] ram_in_r2;
    reg [21:0] ram_in_r3; // Defined ram_in for input to RAM
    wire [95:0] ram_out;
    reg [3:0] read_addr;
    
    reg s_axis_a_tvalid;
    wire s_axis_a_tready;
    wire m_axis_result_tvalid;
    reg m_axis_result_tready; // Added m_axis_result_tready as a reg
    wire [31:0] fl_out; // Corrected fl_out width to match DCT_out size
    reg [1:0] ram_write_cnt;
    reg [3:0] ram_addr_cnt;
    reg CE;
    wire [23:0]adder1_out;
    wire [23:0] adder2_out;
    wire [23:0] adder3_out;
    reg [23:0] adder3_in1;
    reg [23:0] adder3_in2;
    reg [3:0] fifo_22x16_wen_cnt;
    
    reg [2:0] mult_state;
    //reg [21:0] DCT2_out;
    
    parameter IDLE        = 2'b00;
    parameter READ_FIFO_0 = 2'b01;
    parameter READ_RAM    = 2'b10;
    
    parameter r0_mult = 2'b00;
    parameter r1_mult = 2'b01;
    parameter r2_mult = 2'b10;
    parameter r3_mult = 2'b11;


    always @(posedge clk or negedge rst_n) begin
    if(dum_cnt>=90 && dum_cnt<=105) begin
    DCT_2D_out_r0<=fifo_22x4_r0_out;
    DCT_2D_out_r1<=fifo_22x4_r1_out;
    DCT_2D_out_r2<=fifo_22x4_r2_out;
    DCT_2D_out_r3<=fifo_22x4_r3_out;
    end 
    end 
    
	 
    // Generating pulse_1 for write enable
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
        
            d1 <= 0;
            d2 <= 0;
            d3 <= 0;
            d4 <= 0;
            d5 <= 0;
            d6 <= 0;
            d7 <= 0;
            d8 <= 0;
            
            fifo_r0_wren <= 0;
            fifo_r1_wren <= 0;
            fifo_r2_wren <= 0;
            fifo_r3_wren <= 0;
            
        end else begin
        
            d1 <= wen0;
            d2 <= d1;
            d3 <= wen1;
            d4 <= d3;
            d5 <= wen2;
            d6 <= d5;
            d7 <= wen3;
            d8 <= d7; 
            
    	    fifo_r0_wren <= d1 && !d2;
    	    fifo_r1_wren <= d3 && !d4;
    	    fifo_r2_wren <= d5 && !d6;
    	    fifo_r3_wren <= d7 && !d8;
        end
    end
        
        
    always @(posedge clk or negedge rst_n) begin
    	if (!rst_n) begin 
    	mult_state<= r0_mult;
    	end /*else if (wen1!=0) begin 
    	mult_state<= r1_mult;
    	end else if (wen2!= 0) begin 
    	mult_state<= r2_mult;
    	end else if (wen3!= 0) begin 
    	mult_state<= r3_mult;
    	end*/
    	end 

    // State machine for processing data
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_r0 <= IDLE;
            state_r1 <= IDLE;
            state_r2 <= IDLE;
            state_r3 <= IDLE;
            
            fifo_r0_reen <= 1'b0;
            fifo_r1_reen <= 1'b0;
            fifo_r2_reen <= 1'b0;
            fifo_r3_reen <= 1'b0;
            
            mult_cnt <= 4'd0;
            
            CE<=1'b0;
     
            state_cnt <= 5'd0;
            
        end else begin
          
          case (mult_state) 
          	
          	r0_mult: begin 
          
            case (state_r0)
                IDLE: begin
                    if (fifo_r0_full) begin
                        state_r0 <= READ_FIFO_0;
                        fifo_r0_reen <= 1'b1;
                    end
                end

                READ_FIFO_0: begin
                    if (state_cnt == 5'd16) begin 
                        state_r0 <= READ_RAM;
                    end else begin 
                        state_r0 <= READ_FIFO_0;
                        
                    end 
                    if (!fifo_r0_empty) begin
                       
                       
                        
                        s_axis_a_tvalid <= 1'b1;
                        case (mult_cnt) 
                            4'd0 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                          //      ram_addr <= ram_addr + 1;
                              
                            end 
                            4'd1 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd2 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                              ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                            end 
                            4'd3 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                               // read_addr<=read_addr+4;
                            end 
                            4'd4 : begin 
                                mult_B <= 14'b0001010011101;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd5 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd6 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd7 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd8 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1; 
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd9 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd10 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd11 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd12 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd13 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd14 : begin 
                                mult_B <= 14'b00001010011101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd15 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= 0;                               
                                mult_state<=r1_mult;
                                state_cnt<=0;
                                fifo_22x4_r0_wen_delay<=1;
                           //   ram_addr <= ram_addr + 1;
                            end 
                            
                        READ_RAM : begin 
                            CE<=1'b1;
                           
                            end 
                       
                        endcase
                    end 
                end 
            endcase 
        end 
        
        r1_mult: begin 
          
            case (state_r1)
                IDLE: begin
                    if (fifo_r1_full) begin
                        state_r1 <= READ_FIFO_0;
                        fifo_r1_reen <= 1'b1;
                    end
                end

                READ_FIFO_0: begin
                    if (state_cnt == 5'd16) begin 
                        state_r1 <= READ_RAM;
                    end else begin 
                        state_r1 <= READ_FIFO_0;
                        
                    end 
                    if (!fifo_r1_empty) begin
                       
                       
                        
                        s_axis_a_tvalid <= 1'b1;
                        case (mult_cnt) 
                            4'd0 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                          //      ram_addr <= ram_addr + 1;
                              
                            end 
                            4'd1 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd2 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                              ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                            end 
                            4'd3 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                               // read_addr<=read_addr+4;
                            end 
                            4'd4 : begin 
                                mult_B <= 14'b0001010011101;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd5 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd6 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd7 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd8 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1; 
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd9 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd10 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd11 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd12 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd13 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd14 : begin 
                                mult_B <= 14'b00001010011101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd15 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= 0;                               
                                mult_state<=r2_mult;
                                state_cnt<=0;
                                fifo_22x4_r1_wen_delay<=1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            
                        READ_RAM : begin 
                            CE<=1'b1;
                           
                            end 
                       
                        endcase
                    end 
                end 
            endcase 
        end 
        
        r2_mult: begin 
          
            case (state_r2)
                IDLE: begin
                    if (fifo_r2_full) begin
                        state_r2 <= READ_FIFO_0;
                        fifo_r2_reen <= 1'b1;
                    end
                end

                READ_FIFO_0: begin
                    if (state_cnt == 5'd16) begin 
                        state_r2 <= READ_RAM;
                    end else begin 
                        state_r2 <= READ_FIFO_0;
                        
                    end 
                    if (!fifo_r2_empty) begin
                       
                       
                        
                        s_axis_a_tvalid <= 1'b1;
                        case (mult_cnt) 
                            4'd0 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                          //      ram_addr <= ram_addr + 1;
                              
                            end 
                            4'd1 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd2 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                              ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                            end 
                            4'd3 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                               // read_addr<=read_addr+4;
                            end 
                            4'd4 : begin 
                                mult_B <= 14'b0001010011101;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd5 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd6 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd7 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd8 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1; 
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd9 : begin 
                                mult_B <= 14'b11111000000000 ;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd10 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd11 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd12 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd13 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd14 : begin 
                                mult_B <= 14'b00001010011101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd15 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= 0;                               
                                mult_state<=r3_mult;
                                state_cnt<=0;
                                fifo_22x4_r2_wen_delay<=1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            
                        READ_RAM : begin 
                            CE<=1'b1;
                           
                            end 
                       
                        endcase
                    end 
                end 
            endcase 
        end 
        
        r3_mult: begin 
          
            case (state_r3)
                IDLE: begin
                    if (fifo_r3_full) begin
                        state_r3 <= READ_FIFO_0;
                        fifo_r3_reen <= 1'b1;
                    end
                end

                READ_FIFO_0: begin
                    if (state_cnt == 5'd16) begin 
                        state_r3 <= READ_RAM;
                    end else begin 
                        state_r3<= READ_FIFO_0;
                        
                    end 
                    if (!fifo_r3_empty) begin
                       
                       
                        
                        s_axis_a_tvalid <= 1'b1;
                        case (mult_cnt) 
                            4'd0 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                          //      ram_addr <= ram_addr + 1;
                              
                            end 
                            4'd1 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd2 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                              ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                            end 
                            4'd3 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                               // read_addr<=read_addr+4;
                            end 
                            4'd4 : begin 
                                mult_B <= 14'b0001010011101 ;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd5 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd6 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd7 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd8 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1; 
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd9 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd10 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd11 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd12 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd13 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd14 : begin 
                                mult_B <= 14'b00001010011101 ;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd15 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_r0_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                                state_cnt<=0;
                                fifo_22x4_r3_wen_delay<=1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            
                        READ_RAM : begin 
                            CE<=1'b1;
                            
                           
                            end 
                       
                        endcase
                    end 
                end 
            endcase 
        end 
        
        endcase
    end 
    end
    
  
  
  always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin 
    fifo_22x4_r0_off_cnt<=0;
    fifo_22x4_r1_off_cnt<=0;
    fifo_22x4_r2_off_cnt<=0;
    fifo_22x4_r3_off_cnt<=0;
    end else begin 
    
    if (fifo_22x4_r0_wen && fifo_22x4_r0_off_cnt<3'd3) begin 
    fifo_22x4_r0_off_cnt<=fifo_22x4_r0_off_cnt+1;
    end 
    if (fifo_22x4_r1_wen && fifo_22x4_r1_off_cnt<3'd4) begin 
    fifo_22x4_r1_off_cnt<=fifo_22x4_r1_off_cnt+1;
    end 
    if (fifo_22x4_r2_wen && fifo_22x4_r2_off_cnt<3'd5) begin 
    fifo_22x4_r2_off_cnt<=fifo_22x4_r2_off_cnt+1;
    end 
    if (fifo_22x4_r3_wen && fifo_22x4_r3_off_cnt<3'd6) begin 
    fifo_22x4_r3_off_cnt<=fifo_22x4_r3_off_cnt+1;
    end 
    end 
    end 
    
    
    always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin
    dum_cnt<=0;
    end else begin 
    dum_cnt<=dum_cnt+1;
    end
    end
    
    always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin
    fifo_22x16_wen_cnt<=0;
    fifo_22x16_wen<=0;
    fifo_22x16_ren<=0;
    fifo_22x4_r0_ren<=0;
    
    
    fifo_22x4_r1_ren<=0;
    fifo_22x4_r2_ren<=0;
    fifo_22x4_r3_ren<=0;
    end else begin 
    	if(fifo_22x4_r3_wen || fifo_22x16_wen_cnt>=4'd1) begin 
    	fifo_22x16_wen_cnt<=fifo_22x16_wen_cnt+1;
    	end 
   if ( fifo_22x16_wen_cnt>=4'd4 && fifo_22x16_wen_cnt<=4'd8) begin 
   
   fifo_22x4_r0_ren<=1;
   fifo_22x4_r1_ren<=1;
   fifo_22x4_r2_ren<=1;
   fifo_22x4_r3_ren<=1;
   fifo_22x16_wen_cnt<=fifo_22x16_wen_cnt+1;
   end  else begin 
   
   fifo_22x4_r0_ren<=1;
   fifo_22x4_r1_ren<=1;
   fifo_22x4_r2_ren<=1;
   fifo_22x4_r3_ren<=1;
   fifo_22x4_r3_ren<=1;
   end 
    if ( fifo_22x16_wen_cnt>=4'd4 && fifo_22x16_wen_cnt<=4'd8 && fifo_22x4_r0_ren) begin 
   fifo_22x16_wen<=1;
   end else begin 
   fifo_22x16_wen<=0;
   end
     
   end
   end 
   reg [3:0] fifo_22x16_ren_cnt_2;
   always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin
    fifo_22x16_ren<=0;
    fifo_22x16_ren_cnt<=0;
    fifo_22x16_ren_cnt_2<=0;
    end else begin 
    if ((fifo_22x16_wen==1 && fifo_22x16_ren_cnt>=3'd4) || (fifo_22x16_ren_cnt_2>=4'd1 && fifo_22x16_ren_cnt_2<=4'd15)) begin 
    fifo_22x16_ren<=1;
    fifo_22x16_ren_cnt_2<=fifo_22x16_ren_cnt_2+1;
    end else begin 
   fifo_22x16_ren<=0;
   fifo_22x16_ren_cnt<=fifo_22x16_ren_cnt+1;
   end 
   end 
   end

    
  always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin 
    fifo_22x4_r0_wen_cnt<=0;
    fifo_22x4_r1_wen_cnt<=0;
    fifo_22x4_r2_wen_cnt<=0;
    fifo_22x4_r3_wen_cnt<=0;
    
    fifo_22x4_r0_wen<=0;
    fifo_22x4_r1_wen<=0;
    fifo_22x4_r2_wen<=0;
    fifo_22x4_r3_wen<=0;
    
       end else begin 
  	if (fifo_22x4_r0_wen_delay && fifo_22x4_r0_wen_cnt==3'd4 && fifo_22x4_r0_off_cnt<3'd3) begin 
  		fifo_22x4_r0_wen<=1;
  	end else begin
  		fifo_22x4_r0_wen<=0;
  		fifo_22x4_r0_wen_cnt<=fifo_22x4_r0_wen_cnt+1;
  	end
  	
  	if (fifo_22x4_r1_wen_delay && fifo_22x4_r1_wen_cnt==3'd5 && fifo_22x4_r1_off_cnt<3'd3) begin 
  		fifo_22x4_r1_wen<=1;
  	end else begin
  		fifo_22x4_r1_wen<=0;
  		fifo_22x4_r1_wen_cnt<=fifo_22x4_r1_wen_cnt+1;
  	end
  	
  	if (fifo_22x4_r2_wen_delay && fifo_22x4_r2_wen_cnt==3'd6 && fifo_22x4_r2_off_cnt<3'd3) begin 
  		fifo_22x4_r2_wen<=1;
  	end else begin
  		fifo_22x4_r2_wen<=0;
  		fifo_22x4_r2_wen_cnt<=fifo_22x4_r2_wen_cnt+1;
  	end
  	
  	if (fifo_22x4_r3_wen_delay && fifo_22x4_r3_wen_cnt==3'd7 && fifo_22x4_r3_off_cnt<3'd3) begin 
  		fifo_22x4_r3_wen<=1;
  	end else begin
  		fifo_22x4_r3_wen<=0;
  		fifo_22x4_r3_wen_cnt<=fifo_22x4_r3_wen_cnt+1;
  	end 
  end
  end 
  
always @(*) begin

    DCT_r0_out = ram_out_r0[23:0] + ram_out_r0[47:24] + ram_out_r0[71:48] + ram_out_r0[95:72];
    DCT_r1_out = ram_out_r1[23:0] + ram_out_r1[47:24] + ram_out_r1[71:48] + ram_out_r1[95:72];
    DCT_r2_out = ram_out_r2[23:0] + ram_out_r2[47:24] + ram_out_r2[71:48] + ram_out_r2[95:72];
    DCT_r3_out = ram_out_r3[23:0] + ram_out_r3[47:24] + ram_out_r3[71:48] + ram_out_r3[95:72];
    
end
/*
   always @(posedge clk or negedge rst_n) begin
   	
   	if (!rst_n) begin 
   	

   	end else if ( fifo_22x4_r0_full) begin 
   		fifo_22x4_r0_ren<=1;
   		fifo_22x16_wen<=1;
   		
   	end else if ( fifo_22x4_r1_full) begin 
   		fifo_22x4_r1_ren<=1;  		
   		
   	end else if ( fifo_22x4_r2_full) begin 
   		fifo_22x4_r2_ren<=1;
   		
   	end else if ( fifo_22x4_r3_full) begin 
   		fifo_22x4_r3_ren<=1;
   		  	
   	end
   	end 
*/



        
  always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_write_r0<=1'b0;
        ram_write_cnt_r0<=1'b0;
        end 
       
        else if (mult_state== r0_mult) begin 
        if (state_r0==2'd2) begin 
        ram_write_r0<=1'b0; 
        end 
        if (state_r0==2'b01)
        begin 
        if(ram_write_cnt_r0>=2'd1) begin 
        ram_write_r0<=1'b1;
        //ram_write_cnt<=1'b0;
        end else begin 
        ram_write_r0<=1'b0;
        ram_write_cnt_r0<=ram_write_cnt_r0+1;
        end 
        end 
        end 
       end 
       
  always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_write_r1<=1'b0;
        ram_write_cnt_r1<=1'b0;
        end 
       
        else if (mult_state== r1_mult) begin 
        if (state_r1==2'd2) begin 
        ram_write_r1<=1'b0; 
        end 
        if (state_r1==2'b01)
        begin 
        if(ram_write_cnt_r1>=2'd1) begin 
        ram_write_r1<=1'b1;
        //ram_write_cnt<=1'b0;
        end else begin 
        ram_write_r1<=1'b0;
        ram_write_cnt_r1<=ram_write_cnt_r1+1;
        end 
        end 
        end 
       end 
       
         always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_write_r2<=1'b0;
        ram_write_cnt_r2<=1'b0;
        end 
       
        else if (mult_state== r2_mult) begin 
        if (state_r2==2'd2) begin 
        ram_write_r2<=1'b0; 
        end 
        if (state_r2==2'b01)
        begin 
        if(ram_write_cnt_r2>=2'd1) begin 
        ram_write_r2<=1'b1;
        //ram_write_cnt<=1'b0;
        end else begin 
        ram_write_r2<=1'b0;
        ram_write_cnt_r2<=ram_write_cnt_r2+1;
        end 
        end 
        end 
       end 
       
         always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_write_r3<=1'b0;
        ram_write_cnt_r3<=1'b0;
        end 
       
        else if (mult_state== r3_mult) begin 
        if (state_r3==2'd2) begin 
        ram_write_r3<=1'b0; 
        end 
        if (state_r3==2'b01)
        begin 
        if(ram_write_cnt_r3>=2'd1) begin 
        ram_write_r3<=1'b1;
        //ram_write_cnt<=1'b0;
        end else begin 
        ram_write_r3<=1'b0;
        ram_write_cnt_r3<=ram_write_cnt_r3+1;
        end 
        end 
        end 
       end 
       
   always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_addr_r0<=1'b0;
        ram_addr_cnt_r0<=4'd0;
        end else begin 
        if (ram_write_r0==1'b1 && ram_addr_cnt_r0<=4'd15) begin 
        ram_addr_r0<=ram_addr_r0 +1;
        end else begin 
        ram_addr_cnt_r0<=ram_addr_cnt_r0 +1;
        end 
        end 
        end 
        
              
   always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_addr_r1<=1'b0;
        ram_addr_cnt_r1<=4'd0;
        end else begin 
        if (ram_write_r1==1'b1 && ram_addr_cnt_r1<=4'd15) begin 
        ram_addr_r1<=ram_addr_r1 +1;
        end else begin 
        ram_addr_cnt_r1<=ram_addr_cnt_r1 +1;
        end 
        end 
        end 
              
   always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_addr_r2<=1'b0;
        ram_addr_cnt_r2<=4'd0;
        end else begin 
        if (ram_write_r2==1'b1 && ram_addr_cnt_r2<=4'd15) begin 
        ram_addr_r2<=ram_addr_r2 +1;
        end else begin 
        ram_addr_cnt_r2<=ram_addr_cnt_r2 +1;
        end 
        end 
        end 
              
   always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_addr_r3<=1'b0;
        ram_addr_cnt_r3<=4'd0;
        end else begin 
        if (ram_write_r3==1'b1 && ram_addr_cnt_r3<=4'd15) begin 
        ram_addr_r3<=ram_addr_r3 +1;
        end else begin 
        ram_addr_cnt_r3<=ram_addr_cnt_r3 +1;
        end 
        end 
        end 
        
    custom_fifo_22x4 r0 (
    .clk(clk),
    .rst(rst_n),
    .wr_en(fifo_22x4_r0_wen),
    .rd_en(fifo_22x4_r0_ren),
    .din(DCT_r0_out),
    .dout(fifo_22x4_r0_out),
    .full(fifo_22x4_r0_full),
    .empty(fifo_22x4_r0_empty)
);
    

    custom_fifo_22x4 r1 (
    .clk(clk),
    .rst(rst_n),
    .wr_en(fifo_22x4_r1_wen),
    .rd_en(fifo_22x4_r1_ren),
    .din(DCT_r1_out),
    .dout(fifo_22x4_r1_out),
    .full(fifo_22x4_r1_full),
    .empty(fifo_22x4_r1_empty)
);

    custom_fifo_22x4 r2 (
    .clk(clk),
    .rst(rst_n),
    .wr_en(fifo_22x4_r2_wen),
    .rd_en(fifo_22x4_r2_ren),
    .din(DCT_r2_out),
    .dout(fifo_22x4_r2_out),
    .full(fifo_22x4_r2_full),
    .empty(fifo_22x4_r2_empty)
);
   
    custom_fifo_22x4 r3 (
    .clk(clk),
    .rst(rst_n),
    .wr_en(fifo_22x4_r3_wen),
    .rd_en(fifo_22x4_r3_ren),
    .din(DCT_r3_out),
    .dout(fifo_22x4_r3_out),
    .full(fifo_22x4_r3_full),
    .empty(fifo_22x4_r3_empty)
);
        
        
        
        
    custom_fifo_22x16 all (
    .clk(clk),
    .rst(rst_n),
    .wr_en(fifo_22x16_wen),
    .rd_en(fifo_22x16_ren), // 4 read enable signals
    .din0(fifo_22x4_r0_out),
    .din1(fifo_22x4_r1_out),
    .din2(fifo_22x4_r2_out),
    .din3(fifo_22x4_r3_out),
    .dout(DCT_2D_out),
    .full(fifo_22x16_full),
    .empty(fifo_22x16_empty)
);
  
    

    // FIFO instance
    fifo_generator_r0 f0 (
        .clk(clk),
        .srst(!rst_n),
        .din(din0), 
        .wr_en(wen0),
        .rd_en(fifo_r0_reen),
        .dout(fifo_r0_out),
        .full(fifo_r0_full),
        .empty(fifo_r0_empty)
    );
    
    
    // FIFO instance
    fifo_generator_r1 f1 (
        .clk(clk),
        .srst(!rst_n),
        .din(din1), 
        .wr_en(wen1),
        .rd_en(fifo_r1_reen),
        .dout(fifo_r1_out),
        .full(fifo_r1_full),
        .empty(fifo_r1_empty)
    );
    
    // FIFO instance
    fifo_generator_r2 f2 (
        .clk(clk),
        .srst(!rst_n),
        .din(din2), 
        .wr_en(wen2),
        .rd_en(fifo_r2_reen),
        .dout(fifo_r2_out),
        .full(fifo_r2_full),
        .empty(fifo_r2_empty)
    );
    
    // FIFO instance
    fifo_generator_r3 f3 (
        .clk(clk),
        .srst(!rst_n),
        .din(din3), 
        .wr_en(wen3),
        .rd_en(fifo_r3_reen),
        .dout(fifo_r3_out),
        .full(fifo_r3_full),
        .empty(fifo_r3_empty)
    );

    // Multiplier instance
    mult_gen_r0 m0 (
        .A(mult_B), 
        .B(fifo_r0_out), 
        .CLK(clk), 
        .P(mult_r0_out)
    );
    
    
    
    // Multiplier instance
    mult_gen_r1 m1 (
        .A(mult_B), 
        .B(fifo_r1_out), 
        .CLK(clk), 
        .P(mult_r1_out)
    );
    
    // Multiplier instance
    mult_gen_r2 m2 (
        .A(mult_B), 
        .B(fifo_r2_out), 
        .CLK(clk), 
        .P(mult_r2_out)
    );
    
    // Multiplier instance
    mult_gen_r3 m3 (
        .A(mult_B), 
        .B(fifo_r3_out), 
        .CLK(clk), 
        .P(mult_r3_out)
        );

    // custom ram
    custom_ram c0(
    .clk(clk),
    .rst_n(rst_n),
   .write(ram_write_r0),  
   .din(mult_r0_out),
    .write_addr(ram_addr_r0),
    .final_dout(),
    .dout(ram_out_r0)
    );
     
    custom_ram c1(
    .clk(clk),
    .rst_n(rst_n),
   .write(ram_write_r1),  
   .din(mult_r1_out),
    .write_addr(ram_addr_r1),
    .final_dout(),
    .dout(ram_out_r1)
    );


    custom_ram c2(
    .clk(clk),
    .rst_n(rst_n),
   .write(ram_write_r2),  
   .din(mult_r2_out),
    .write_addr(ram_addr_r2),
    .final_dout(),
    .dout(ram_out_r2)
    );


    custom_ram c3(
    .clk(clk),
    .rst_n(rst_n),
   .write(ram_write_r3),  
   .din(mult_r3_out),
    .write_addr(ram_addr_r3),
    .final_dout(),
    .dout(ram_out_r3)
    );


endmodule
