
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nikhil
// 
// Create Date: 10/19/2024 01:55:01 PM
// Design Name: 
// Module Name: had_transform_source
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

module had_transform_source(
    input  [3:0] din,
    input clk,
    input rst_n,
    input wen,
    
   
    output  [6:0] had_out
);

    // Internal signals
    reg ram_read;
    reg [3:0] ram_in;
    wire [15:0] ram_out;
    reg [15:0] add_in;
    wire [5:0] add_out_2;
    wire [5:0] add_out_1;
    wire [6:0] adder_out_3;
    reg [6:0] fifo_in;
    wire empty;
    wire full;
    wire empty_2;
    wire full_2;
    reg ram_write;
    reg [27:0] clk_1sec_cnt; 
    

    reg [3:0] ram_addr;
    reg [26:0] cnt_1sec;
    reg clk_1sec;
    wire [3:0] dout;
    reg [2:0] state_cnt;
    reg fifo_2_wr_en;
    reg [1:0] ram_cnt;
    reg [3:0] cnt;
    reg [2:0] cnt2;

    reg d1, d2, d5, d6;
    reg pulse_1, pulse_3;
    reg read_fifo0;
    reg [1:0] state;
    reg CE;
    reg [5:0] adder_in_3A;
    reg [5:0] adder_in_3B;
    reg add_sub_1, add_sub_2;
    reg delay;
    
    reg [4:0] add_in_A01;
    reg [4:0] add_in_A02;
    reg [4:0] add_in_A11;
    reg [4:0] add_in_A12;
    
    reg [4:0] last_cnt;
    reg [4:0] adder_output_cnt;
    reg [3:0] CE_delay_cnt;
    reg [1:0]ram_addr_cnt;
    reg [2:0] add_sub_cnt;
    reg [2:0] CE_cnt;
    reg fifo_2_wr;
    reg [1:0] fifo_2_wr_cnt;
    
    // State encoding
    parameter IDLE        = 2'b00;
    parameter READ_FIFO_0 = 2'b01;
    parameter READ_FIFO_1 = 2'b10;
    parameter READ_RAM    = 2'b11;
    
   
   

    // Pulse generation for write enable (wen)
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

    // Pulse generation for FIFO 2 read enable
 /*   always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            d5 <= 0;
            d6 <= 0;
            pulse_3 <= 0;
        end else begin
            d5 <= ren;
            d6 <= d5;
            pulse_3 <= d5 && !d6;
        end
    end*/

    // State machine logic with IDLE and WRITE_FIFO_0 state added
    always @(posedge clk or negedge rst_n) begin
    //pulse_3<=1'b1;
        if (!rst_n) begin
            state <= IDLE;
            state_cnt <= 3'd0;
            cnt <= 4'd15;
            last_cnt <= 5'd16;
          /*  ram_write <= 1'b0;*/
            read_fifo0 <= 1'b0;
            ram_addr <= 4'd0;
            cnt2 <= 3'd0;
           /*CE<=1'b0;*/
            add_sub_1 <= 1'b0;
            add_sub_2<= 1'b0;
            delay<= 1'b0;
            ram_addr_cnt<=1'b0;
            add_sub_cnt<=3'b0;
            fifo_2_wr_en<=1'b0;
            
            
            
            
        end else begin
            case (state)
                IDLE: begin
                    if (full) begin
                        state <= READ_FIFO_0;
                    end
                end

                READ_FIFO_0: begin
                    if (!empty) begin
                        /*ram_write <= 1'b1;*/
                        read_fifo0 <= 1'b1;
                        ram_in <= dout;
                        if (ram_addr_cnt>=2'd3) begin 
                            ram_addr <= ram_addr + 1;
                            end else begin
                            ram_addr<=2'd0;
                            ram_addr_cnt<= ram_addr_cnt +1; end 
                        state<=READ_FIFO_0;
                    end else if (read_fifo0) begin
                       /* ram_write <= 1'b1;*/
                        ram_in <= dout;
                        ram_addr <= ram_addr + 1;
                        read_fifo0 <= 1'b0;
                      /*  ram_write <= 1'b0;*/
                        state <= READ_RAM;
                    end else begin
                      /*  ram_write <= 1'b0;*/
                        state <= READ_RAM;
                    end
                end

                READ_RAM: begin
                 ram_addr <= state_cnt*4;
                 if ((state_cnt>=3'd1 && state_cnt<=3'd5)&&(!full_2)) begin  
                 fifo_2_wr_en <= 1'b1; end 
                 else begin 
                 fifo_2_wr_en<=1'b0; end 
                if (state_cnt == 3'd5) begin
                            
                            
                            state <= IDLE;
                            /*CE<= 1'b0;*/
                            
                        end else begin
                                
                            state <= READ_RAM;
                          end 
                /*
                    if (cnt2 < 4) begin
                        ram_addr <= state_cnt*4;
                        fifo_2_wr_en <= 1'b1;
                       CE<=1'b1;*/
                                add_in_A01<=ram_out[3:0];
                                add_in_A02<=ram_out[7:4];
                                add_in_A11<=ram_out[11:8];
                                add_in_A12<=ram_out[15:12];
                                

                        case (cnt2)
                            3'd0: begin
                               
                              /* if (CE==1'b1) begin */
                                add_sub_1 <= 1'b0;
                                delay <= 1'b1; 
                                add_sub_2 <= delay;
                                
                                
                             /*   adder_in_3A <= add_out_1;
                                adder_in_3B <= add_out_2;*/
                                cnt2 <= cnt2 + 1;
                              /*  fifo_in <= adder_out_3;*/
                                
                               
                                
                                
                            end
                            3'd1: begin
                            /* if (CE==1'b1) begin*/
                                add_sub_1 <= 1'b1;
                                delay <= 1'b0;
                                add_sub_2 <= delay;
                                
                                
                              /*  adder_in_3A <= add_out_1;
                                adder_in_3B <= add_out_2;*/
                                cnt2 <= cnt2 + 1;
                             /*   fifo_in <= adder_out_3;*/
                            end
                            3'd2: begin
                             /* if (CE==1'b1) begin*/
                                add_sub_1 <= 1'b0;
                                delay <= 1'b0;
                                add_sub_2 <= delay;
                               
                                
                             /*   adder_in_3A <= add_out_1;
                                adder_in_3B <= add_out_2;*/
                                cnt2 <= cnt2 + 1;
                             /*   fifo_in <= adder_out_3;*/
                               
                            end
                           default: begin
                              /* if (CE==1'b1) begin */
                                add_sub_1 <= 1'b1;
                                delay <= 1'b1;
                                add_sub_2 <= delay;
                                state_cnt<=state_cnt+1;
                               
                       /* adder_in_3A <= add_out_1;
                                adder_in_3B <= add_out_2;*/
                                cnt2 <= 0;
                           /*     fifo_in <= adder_out_3;*/
                               
                            end
                        endcase
                        
                             
                    end 
                    
               
                
            endcase
        end 
    end

    // LED output logic
 /*   always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            ledout <= 8'd0;
        end else if (full_2 || last_cnt > 0) begin
            ledout <= had_out;
            last_cnt <= last_cnt - 1;
        end
    end*/
    
     always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        ram_write<=1'b0; end 
     else if(ram_addr==4'b1111) begin 
        ram_write<=1'b0;
        end else if(!empty) begin
            ram_write<=1'b1;
            end 
            end 
            
  /* always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            fifo_2_wr <= 1'd0; end 
        else begin 
                 if ((state_cnt>=3'd1 && state_cnt<=3'd5)&&(state==2'd3)) begin  
                 fifo_2_wr <= 1'b1; end 
                 else begin 
                 fifo_2_wr<=1'b0; end 
            end 
            end 
            
            */
            
                        
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            fifo_2_wr <= 1'd0;
            fifo_2_wr_cnt<= 2'd0;end 
           else
           begin 
            if (fifo_2_wr_en==1'b1&&fifo_2_wr_cnt==2'd3&&state==2'd3) begin
            fifo_2_wr <=1'd1;
             end 
             else begin 
             fifo_2_wr<=1'd0;
            fifo_2_wr_cnt<= fifo_2_wr_cnt +1; end 
            end 
            end 
            
            
  /*  
     always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        CE<=1'b0; end 
        else if (state_cnt>=3'd1 && state_cnt<=3'd3) begin 
            CE<= 1'b1;
            end else begin 
            CE<=1'b0; end 
            end */

    always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin
        CE<=1'b0; 
        CE_cnt<=1'b0; end 
        else if (state==READ_RAM) begin 
            if (CE_cnt>= 3'd3 || /*fifo_2_wr_en==1'd1*/ state==2'd0) begin
                CE<= 1'b1; end 
                
                else begin 
                CE<=1'b0;
                CE_cnt<= CE_cnt+1; end 
           end 
           else begin 
           CE<=1'b0; 
           end 
           end
           
  /*
     always @(posedge clk or negedge rst_n) begin
     if (!rst_n) begin 
        add_sub_1 <= 1'b0;
            add_sub_2<= 1'b0;
            delay<= 1'b0; end 
        else if (state_cnt>=3'd1 && state_cnt<=3'd3) begin 
             case (cnt2)
                            3'd0: begin
                               
                                
                                add_sub_1 <= 1'b1;
                                delay <= 1'b1; 
                                add_sub_2 <= delay;
                                end 
                                
                            3'd1: begin
                                
                                add_sub_1 <= 1'b0;
                                delay <= 1'b1;
                                add_sub_2 <= delay;
                                end 
                                
                             3'd2: begin
                              
                                add_sub_1 <= 1'b1;
                                delay <= 1'b0;
                                add_sub_2 <= delay;
                                end 
                             
                             default: begin
                                
                                add_sub_1 <= 1'b0;
                                delay <= 1'b0;
                                add_sub_2 <= delay;
                                end 
                                endcase
                                end 
                                end 
                   
*/

        always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
        clk_1sec<=1'b0;
        clk_1sec_cnt<=28'd0; end 
        else begin  
          if (clk_1sec_cnt==28'd999) begin 
            clk_1sec<=!clk_1sec;
            clk_1sec_cnt<=28'd0; end 
            else begin 
            clk_1sec_cnt<= clk_1sec_cnt+1; 
            clk_1sec<=clk_1sec;
            end 
            end 
            end 

    
    // LED output logic
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
           /// ledout <= 8'd0;
            pulse_3<=1'b0;
        end else if (!empty_2 && clk_1sec_cnt==28'd0) begin
            pulse_3<=1'b1;
          ///  ledout <= had_out;
            last_cnt <= last_cnt - 1; end 
            else begin 
            pulse_3<=1'b0; end 
        end     
        
    // FIFO and RAM instances
    fifo_generator_0 f0 (
        .clk(clk),
        .srst(~rst_n),
        .din(din),
        .wr_en(pulse_1),
        .rd_en(read_fifo0),
        .dout(dout),
        .full(full),
        .empty(empty)
    );
/*
    fifo_generator_1 f1 (
        .clk(clk),
        .srst(~rst_n),
        .din(fifo_in),
        .wr_en(fifo_2_wr),
        .rd_en(pulse_3),
        .dout(had_out),
        .full(full_2),
        .empty(empty_2)
    );*/
    
    fifocustom f2(
     .clk(clk),
   .clk2(clk),
     .wen(fifo_2_wr),
     .ren(pulse_3),
     .din(adder_out_3),
    .rst_n(rst_n),
    .dout(had_out),
     .full(full_2),
     .empty(empty_2)
   /* valid*/
);

    blk_mem_gen_0 ram (
        .clka(clk),
        .wea(ram_write),
        .addra(ram_addr),
        .dina(ram_in),
        .douta(ram_out)
    );

    c_addsub_0 A0 (
        .CLK(clk),
        .CE(CE),
        .ADD(add_sub_1),
        .A({1'b0,add_in_A01}),
        .B({1'b0,add_in_A02}),
        .S(add_out_1)
    );

    c_addsub_1 A1 (
        .CLK(clk),
        .CE(CE),
        .ADD(add_sub_1),
        .A({1'b0,add_in_A11}),
        .B({1'b0,add_in_A12}),
        .S(add_out_2)
    );

    c_addsub_2 A2 (
        .CLK(clk),
        .CE(CE),
        .A(add_out_1),
        .B(add_out_2),
        .S(adder_out_3),
        .ADD(add_sub_2)
        
    );
endmodule

