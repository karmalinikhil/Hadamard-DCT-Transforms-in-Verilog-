

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

module DCT_source(
    input  [7:0] din,
    input clk,
    input rst_n,
    input wen,
    output  [6:0] DCT_out
);
    
    reg d1;
    reg d2;
    reg pulse_1;
    reg ren; 
    wire [7:0] fifo0_out;
    wire full;
    wire empty;
    reg [1:0] state;
    reg [13:0] mult_B;
    wire [21:0] mult_out; // Corrected to match mult_gen_0 output size
    reg [3:0] mult_cnt;
    reg [4:0] state_cnt;
    reg ram_write;
    reg ram_read;
    reg [3:0] ram_addr;
    reg [21:0] ram_in; // Defined ram_in for input to RAM
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
    //reg [21:0] DCT2_out;
    
    parameter IDLE        = 2'b00;
    parameter READ_FIFO_0 = 2'b01;
    parameter READ_RAM    = 2'b10;

    // Generating pulse_1 for write enable
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            d1 <= 0;
            d2 <= 0;
            pulse_1 <= 0;
        end else begin
            d1 <= wen;
            d2 <= d1;
            pulse_1 <= d1 && !d2;
        end
    end

always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          read_addr<=1'b0;
          end else begin 
          if(mult_cnt>=4'd1) begin 
          read_addr<=ram_addr+1;
          end else begin 
          read_addr<=1'b0;
          end 
          end 
          end 
          
always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_read<=1'b0;
        end else begin 
        if(ram_addr==4'd15) begin 
        ram_read<=1'b1;
        end 
        end 
        end 
        

    // State machine for processing data
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            ren <= 1'b0;
            mult_cnt <= 4'd0;
            s_axis_a_tvalid <= 1'b0;
            CE<=1'b0;
         //   adder3_in1<=25'd0;
         //   adder3_in2<=25'd0;
        //    read_addr<=1'b0;
            
           
         //   ram_addr <= 4'b0;
            state_cnt <= 5'd0;
            //m_axis_result_tready <= 1'b0; // Set m_axis_result_tready to 1
        end else begin
            case (state)
                IDLE: begin
                    if (full) begin
                        state <= READ_FIFO_0;
                        ren <= 1'b1;
                    end
                end

                READ_FIFO_0: begin
                    if (state_cnt == 5'd16) begin 
                        state <= READ_RAM;
                    end else begin 
                        state <= READ_FIFO_0;
                        
                    end 
                    if (!empty) begin
                       
                       
                        
                        s_axis_a_tvalid <= 1'b1;
                        case (mult_cnt) 
                            4'd0 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                          //      ram_addr <= ram_addr + 1;
                              
                            end 
                            4'd1 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd2 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                              ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                            end 
                            4'd3 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                             //   ram_addr <= ram_addr + 1;
                               // read_addr<=read_addr+4;
                            end 
                            4'd4 : begin 
                                mult_B <= 14'b00001010011101;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd5 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                              //  ram_addr <= ram_addr + 1;
                            end 
                            4'd6 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd7 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd8 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1; 
                           //     ram_addr <= ram_addr + 1;
                            end 
                            4'd9 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd10 : begin 
                                mult_B <= 14'b11111000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd11 : begin 
                                mult_B <= 14'b00001000000000;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd12 : begin 
                                mult_B <= 14'b00000100010101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd13 : begin 
                                mult_B <= 14'b11110101100011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd14 : begin 
                                mult_B <= 14'b00001010011101;
                                s_axis_a_tvalid <= 1'b1;
                                ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                            //    ram_addr <= ram_addr + 1;
                            end 
                            4'd15 : begin 
                                mult_B <= 14'b11111011101011;
                                s_axis_a_tvalid <= 1'b1;
                               ram_in <= mult_out;
                                state_cnt <= state_cnt + 1;
                                mult_cnt <= mult_cnt + 1;
                           //     ram_addr <= ram_addr + 1;
                            end 
                            
                        READ_RAM : begin 
                            CE<=1'b1;
                            /*adder3_in1<=adder1_out;
                            adder3_in2<=adder2_out;*/
                            
                            end 
                       
                        endcase
                    end 
                end 
            endcase 
        end 
    end 
    
  reg [21:0] DCT2_out; // 25 bits for the sum
always @(*) begin
    DCT2_out = ram_out[23:0] + ram_out[47:24] + ram_out[71:48] + ram_out[95:72];
end

    
    
  always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        adder3_in1<=25'd0;
        adder3_in2<=25'd0;
        end else begin 
        if (CE==1'b1) begin 
        adder3_in1<=adder1_out;
        adder3_in2<=adder2_out;
        end else begin 
        adder3_in1<=25'd0;
        adder3_in2<=25'd0;
        end 
        end 
        end 
        
        
        
        
        
        
        
          
  always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_write<=1'b0;
        ram_write_cnt<=1'b0;
        end 
        else begin 
        if (state==2'd2) begin 
        ram_write<=1'b0; 
        end 
        if (state==2'b01)
        begin 
        if(ram_write_cnt>=2'd1) begin 
        ram_write<=1'b1;
        //ram_write_cnt<=1'b0;
        end else begin 
        ram_write<=1'b0;
        ram_write_cnt<=ram_write_cnt+1;
        end 
        end 
        end 
       end 
       
   always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
        ram_addr<=1'b0;
        ram_addr_cnt<=4'd0;
        end else begin 
        if (ram_write==1'b1 && ram_addr_cnt<=4'd15) begin 
        ram_addr<=ram_addr +1;
        end else begin 
        ram_addr_cnt<=ram_addr_cnt +1;
        end 
        end 
        end 
 
    // FIFO instance
    fifo_generator_0 f0 (
        .clk(clk),
        .srst(!rst_n),
        .din(din), 
        .wr_en(pulse_1),
        .rd_en(ren),
        .dout(fifo0_out),
        .full(full),
        .empty(empty)
    );

    // Multiplier instance
    mult_gen_0 m1 (
        .A(fifo0_out), 
        .B(mult_B), 
        .CLK(clk), 
        .P(mult_out)
    );

    // Floating-point unit instance
    floating_point_0 fl1 (
        .aclk(clk),
        .s_axis_a_tdata(mult_out),
        .s_axis_a_tvalid(s_axis_a_tvalid),
        .s_axis_a_tready(s_axis_a_tready),
        .m_axis_result_tdata(fl_out),
        .m_axis_result_tvalid(m_axis_result_tvalid),
        .m_axis_result_tready(m_axis_result_tready)
    );

/*    // RAM instance
    blk_mem_gen_0 r0 (
        .clka(clk),
        .wea(ram_write),
        .addra(ram_addr),
        .dina(mult_out),
        .douta(ram_out)
    );*/
    
    custom_ram c0(
    .clk(clk),
    .rst_n(rst_n),
   .write(ram_write),
   
   .din(mult_out),
    .write_addr(ram_addr),
    .final_dout(),
    .dout(ram_out)
    );

    // Assign final output
   // assign DCT_out = fl_out;
    
endmodule
