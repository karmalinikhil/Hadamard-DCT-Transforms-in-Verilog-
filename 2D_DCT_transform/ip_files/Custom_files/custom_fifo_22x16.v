module custom_fifo_22x16 (
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en, // 4 read enable signals
    input wire [21:0] din0,
    input wire [21:0] din1,
    input wire [21:0] din2,
    input wire [21:0] din3,
    output reg [21:0] dout,
    output reg [3:0] full,
    output reg [3:0] empty
);
    
    reg [21:0] fifo_mem [0:15]; // 16-location FIFO of 22-bit width
    reg [3:0] wr_ptr, rd_ptr, count;
    reg [1:0] batch; // Tracks which batch of 4 values is being filled
    
    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            batch  <= 0;
            full   <= 0;
            empty  <= 4'b1111;
        end else begin
            // Write Operation (Only writes in batches of 4)
            if (!full[batch] && wr_en) begin
                fifo_mem[wr_ptr]     <= din0;
                fifo_mem[wr_ptr + 1] <= din1;
                fifo_mem[wr_ptr + 2] <= din2;
                fifo_mem[wr_ptr + 3] <= din3;
                wr_ptr <= wr_ptr + 4;
                count  <= count + 4;
                full[batch] <= 1; // Mark this batch as full
                empty[batch] <= 0;
                batch <= batch + 1; // Move to next batch
            end
            
            // Read Operation (FIFO pumps out all 16 values when wr_en is given)
            if (wr_en && count == 16) begin
                rd_ptr <= 0; // Reset read pointer
                count <= 0;
                dout <= fifo_mem[rd_ptr]; // Read first value
            end else if (rd_en) begin
                dout <= fifo_mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
            
            if (count == 0) begin
                full  <= 0; // Reset full flags
                empty <= 4'b1111; // Reset empty flags
                batch <= 0;
            end
        end
    end
endmodule


