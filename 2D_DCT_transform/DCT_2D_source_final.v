`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2025 07:49:14 PM
// Design Name: 
// Module Name: DCT_2D_source_final
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


module DCT_2D_source_final(
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
    output  wire [35:0] DCT_2D_out_final_r0,
    output  wire [35:0] DCT_2D_out_final_r1,
    output  wire [35:0] DCT_2D_out_final_r2,
    output  wire [35:0] DCT_2D_out_final_r3,
    output wire [35:0] DCT_2D_train_out
    );
    
    
    reg wen0_new; 
    reg wen1_new;
    reg wen2_new;
    reg wen3_new;

wire [21:0] DCT_2D_out_r0_temp;
wire [21:0] DCT_2D_out_r1_temp;
wire [21:0] DCT_2D_out_r2_temp;
wire [21:0] DCT_2D_out_r3_temp;

wire [21:0] DCT_2D_out_r0_trans;
wire [21:0] DCT_2D_out_r1_trans;
wire [21:0] DCT_2D_out_r2_trans;
wire [21:0] DCT_2D_out_r3_trans;
reg valid;
wire valid_out;

reg [7:0] dum_cnt_new;
reg [9:0] dum_cnt_final;


    DCT_2D_source utt (
    .din0(din0),
    .din1(din1),
    .din2(din2),
    .din3(din3),
    .clk(clk),
    .rst_n(rst_n),
    .wen0(wen0),
    .wen1(wen1),
    .wen2(wen2),
    .wen3(wen3),
    .DCT_2D_out_r0(DCT_2D_out_r0_temp),
    .DCT_2D_out_r1(DCT_2D_out_r1_temp),
    .DCT_2D_out_r2(DCT_2D_out_r2_temp),
    .DCT_2D_out_r3(DCT_2D_out_r3_temp)
);

    DCT_2D_source_mult2 dct (
    .din0(DCT_2D_out_r3_trans),
    .din1(DCT_2D_out_r1_trans),
    .din2(DCT_2D_out_r0_trans),
    .din3(DCT_2D_out_r2_trans),
    .clk(clk),
    .rst_n(rst_n),
    .wen0(wen0_new),
    .wen1(wen1_new),
    .wen2(wen2_new),
    .wen3(wen3_new),
    .DCT_2D_out_r0(DCT_2D_out_final_r0),
    .DCT_2D_out_r1(DCT_2D_out_final_r1),
    .DCT_2D_out_r2(DCT_2D_out_final_r2),
    .DCT_2D_out_r3(DCT_2D_out_final_r3),
    .DCT_2D_out(DCT_2D_train_out)
);

 trans_mat tt(
     .clk(clk),
     .rst(rst_n),
    .valid_in(valid),
      .col_in0(DCT_2D_out_r0_temp),
      .col_in1(DCT_2D_out_r1_temp),
     .col_in2(DCT_2D_out_r2_temp),
     .col_in3(DCT_2D_out_r3_temp),
      .valid_out(valid_out),
      .col_out0(DCT_2D_out_r0_trans),
      .col_out1(DCT_2D_out_r1_trans),
       .col_out2(DCT_2D_out_r2_trans),
      .col_out3(DCT_2D_out_r3_trans)
);






    always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin
    dum_cnt_new<=0;
    dum_cnt_final<=0;
    end else begin 
    dum_cnt_new<=dum_cnt_new+1;
    dum_cnt_final<=dum_cnt_final+1;
    end
    end

    always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
    wen0_new<=0;
    wen1_new<=0;
    wen2_new<=0;
    wen3_new<=0;
    end else begin 
    if(dum_cnt_new>=96 && dum_cnt_new<=112) begin
    wen0_new<=1;
    wen1_new<=1;
    wen2_new<=1;
    wen3_new<=1;
    end else begin 
    wen0_new<=0;
    wen1_new<=0;
    wen2_new<=0;
    wen3_new<=0;
    end 
    end 
    end 
    
    always @(posedge clk or negedge rst_n) begin
  
    if (!rst_n) begin
    valid<=0;
    end else begin 
    if (dum_cnt_new>=91 && dum_cnt_new<=94) begin 
    valid<=1;
    end 
    else begin 
    valid<=0;
    end 
    end 
    end 
    











endmodule





