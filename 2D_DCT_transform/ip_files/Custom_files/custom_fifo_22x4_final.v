
module custom_fifo_22x4_final (
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [35:0] din,
    output reg [35:0] dout,
    output reg full,
    output reg empty
);
    
    reg [35:0] fifo_mem [0:3]; // 4-location FIFO of 22-bit width
    reg [1:0] wr_ptr, rd_ptr, count;
    
    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            full   <= 0;
            empty  <= 1;
        end else begin
            // Write Operation
            if (wr_en && !full) begin
                fifo_mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end
            
            // Read Operation
            if (rd_en) begin
                dout <= fifo_mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
            
            // Update full and empty flags
            full  <= (count == 4);
            empty <= (count == 0);
        end
    end
endmodule